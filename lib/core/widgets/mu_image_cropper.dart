import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

/// Lets the person frame a photo before it is uploaded: pinch to zoom, drag
/// to arrange, rotate in quarter turns, inside a fixed [aspect] frame (3 for
/// a cover, 1 for a profile photo; [round] shows a circle guide). Returns
/// the framed image as JPEG bytes no wider than [maxWidth], or null when
/// cancelled.
Future<Uint8List?> showMuImageCropper(
  BuildContext context, {
  required Uint8List bytes,
  required double aspect,
  required String title,
  bool round = false,
  int maxWidth = 1600,
}) {
  return Navigator.of(context).push<Uint8List>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _CropScreen(source: bytes, aspect: aspect, title: title, round: round, maxWidth: maxWidth),
    ),
  );
}

/// A decoded, upright working copy of the photo (EXIF orientation applied,
/// longest side at most 2400px) so what is shown is exactly what is cropped.
class _Prepared {
  const _Prepared(this.bytes, this.width, this.height);
  final Uint8List bytes;
  final int width;
  final int height;
}

_Prepared? _prepare(Uint8List source) {
  final decoded = img.decodeImage(source);
  if (decoded == null) return null;
  var upright = img.bakeOrientation(decoded);
  const longest = 2400;
  if (math.max(upright.width, upright.height) > longest) {
    upright = upright.width >= upright.height
        ? img.copyResize(upright, width: longest, interpolation: img.Interpolation.average)
        : img.copyResize(upright, height: longest, interpolation: img.Interpolation.average);
  }
  return _Prepared(Uint8List.fromList(img.encodeJpg(upright, quality: 92)), upright.width, upright.height);
}

/// [args]: bytes, quarterTurns, x, y, w, h (in rotated-image pixels), maxWidth.
Uint8List _crop(List<Object> args) {
  final bytes = args[0] as Uint8List;
  final turns = args[1] as int;
  var image = img.decodeJpg(bytes)!;
  if (turns % 4 != 0) image = img.copyRotate(image, angle: 90 * (turns % 4));
  final x = (args[2] as double).round().clamp(0, image.width - 1);
  final y = (args[3] as double).round().clamp(0, image.height - 1);
  final w = (args[4] as double).round().clamp(1, image.width - x);
  final h = (args[5] as double).round().clamp(1, image.height - y);
  var out = img.copyCrop(image, x: x, y: y, width: w, height: h);
  final maxWidth = args[6] as int;
  if (out.width > maxWidth) out = img.copyResize(out, width: maxWidth, interpolation: img.Interpolation.average);
  return Uint8List.fromList(img.encodeJpg(out, quality: 88));
}

class _CropScreen extends StatefulWidget {
  const _CropScreen({
    required this.source,
    required this.aspect,
    required this.title,
    required this.round,
    required this.maxWidth,
  });

  final Uint8List source;
  final double aspect;
  final String title;
  final bool round;
  final int maxWidth;

  @override
  State<_CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<_CropScreen> {
  _Prepared? _photo;
  bool _failed = false;
  bool _saving = false;
  int _turns = 0;

  // Image placement inside the frame: scale (logical px per image px) and
  // the image's top-left relative to the frame's top-left.
  double _scale = 1;
  Offset _offset = Offset.zero;
  Size _frame = Size.zero;

  // Gesture start state.
  double _scale0 = 1;
  Offset _offset0 = Offset.zero;
  Offset _focal0 = Offset.zero;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final prepared = await compute(_prepare, widget.source);
    if (!mounted) return;
    setState(() {
      _photo = prepared;
      _failed = prepared == null;
    });
  }

  /// The photo's size after the quarter turns.
  Size get _imageSize {
    final p = _photo!;
    return _turns.isOdd ? Size(p.height.toDouble(), p.width.toDouble()) : Size(p.width.toDouble(), p.height.toDouble());
  }

  double get _minScale => math.max(_frame.width / _imageSize.width, _frame.height / _imageSize.height);

  /// Keeps the frame fully covered by the photo.
  Offset _clamp(Offset o, double s) {
    final w = _imageSize.width * s;
    final h = _imageSize.height * s;
    return Offset(o.dx.clamp(_frame.width - w, 0.0), o.dy.clamp(_frame.height - h, 0.0));
  }

  /// Fits the photo to cover the frame, centred.
  void _fit() {
    _scale = _minScale;
    final w = _imageSize.width * _scale;
    final h = _imageSize.height * _scale;
    _offset = Offset((_frame.width - w) / 2, (_frame.height - h) / 2);
  }

  void _rotate() {
    HapticFeedback.selectionClick();
    setState(() {
      _turns = (_turns + 1) % 4;
      _fit();
    });
  }

  Future<void> _done() async {
    final p = _photo;
    if (p == null || _saving) return;
    setState(() => _saving = true);
    final x = -_offset.dx / _scale;
    final y = -_offset.dy / _scale;
    final w = _frame.width / _scale;
    final h = _frame.height / _scale;
    final out = await compute(_crop, <Object>[p.bytes, _turns, x, y, w, h, widget.maxWidth]);
    if (mounted) Navigator.of(context).pop(out);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: c.night,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(MuSpacing.space2, MuSpacing.space2, MuSpacing.space2, 0),
                child: Row(
                  children: [
                    MuIconButton(
                      icon: LucideIcons.x,
                      tooltip: 'Cancel',
                      variant: MuIconButtonVariant.glass,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: mu.text.title3.copyWith(color: c.onNight),
                      ),
                    ),
                    MuIconButton(
                      icon: LucideIcons.rotateCw,
                      tooltip: 'Rotate',
                      variant: MuIconButtonVariant.glass,
                      onPressed: _photo == null || _saving ? null : _rotate,
                    ),
                  ],
                ),
              ),
              Expanded(child: _editor(context)),
              Padding(
                padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space2),
                child: Text(
                  'Pinch to zoom, drag to arrange',
                  textAlign: TextAlign.center,
                  style: mu.text.caption.copyWith(color: c.onNight2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space2,
                  MuSpacing.space5,
                  MuSpacing.space4,
                ),
                child: MuButton(
                  label: 'Use photo',
                  variant: MuButtonVariant.volt,
                  block: true,
                  loading: _saving,
                  loadingLabel: 'Saving…',
                  onPressed: _photo == null ? null : _done,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editor(BuildContext context) {
    final c = context.mu.colors;
    if (_failed) {
      return Center(
        child: Text("Couldn't open this photo.", style: context.mu.text.body.copyWith(color: c.onNight2)),
      );
    }
    final p = _photo;
    if (p == null) return Center(child: CircularProgressIndicator(color: c.volt));

    return LayoutBuilder(
      builder: (context, box) {
        const pad = MuSpacing.space5;
        final maxW = box.maxWidth - pad * 2;
        final maxH = box.maxHeight - pad * 2;
        var fw = maxW;
        var fh = fw / widget.aspect;
        if (fh > maxH) {
          fh = maxH;
          fw = fh * widget.aspect;
        }
        final frame = Size(fw, fh);
        if (frame != _frame) {
          _frame = frame;
          _fit();
        }
        final frameRect = Rect.fromCenter(center: box.biggest.center(Offset.zero), width: fw, height: fh);
        final imageSize = _imageSize;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onScaleStart: (d) {
            _scale0 = _scale;
            _offset0 = _offset;
            _focal0 = d.localFocalPoint - frameRect.topLeft;
          },
          onScaleUpdate: (d) {
            final focal = d.localFocalPoint - frameRect.topLeft;
            final s = (_scale0 * d.scale).clamp(_minScale, _minScale * 8);
            // Keep the point under the fingers under the fingers.
            final o = focal - (_focal0 - _offset0) * (s / _scale0);
            setState(() {
              _scale = s;
              _offset = _clamp(o, s);
            });
          },
          onDoubleTap: () => setState(_fit),
          child: Stack(
            children: [
              Positioned(
                left: frameRect.left + _offset.dx,
                top: frameRect.top + _offset.dy,
                width: imageSize.width * _scale,
                height: imageSize.height * _scale,
                child: RotatedBox(
                  quarterTurns: _turns,
                  child: Image.memory(p.bytes, fit: BoxFit.fill, gaplessPlayback: true),
                ),
              ),
              // Dim everything outside the frame; outline the frame.
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _FramePainter(
                      frame: frameRect,
                      round: widget.round,
                      scrim: c.night.withValues(alpha: 0.72),
                      line: c.onNight.withValues(alpha: 0.9),
                      grid: c.onNight.withValues(alpha: 0.28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FramePainter extends CustomPainter {
  _FramePainter({
    required this.frame,
    required this.round,
    required this.scrim,
    required this.line,
    required this.grid,
  });

  final Rect frame;
  final bool round;
  final Color scrim;
  final Color line;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    final hole = round
        ? (Path()..addOval(frame))
        : (Path()..addRRect(RRect.fromRectAndRadius(frame, const Radius.circular(MuRadii.tag))));
    final outside = Path.combine(PathOperation.difference, Path()..addRect(Offset.zero & size), hole);
    canvas.drawPath(outside, Paint()..color = scrim);

    // Rule of thirds inside the frame.
    final g = Paint()
      ..color = grid
      ..strokeWidth = 1;
    canvas
      ..save()
      ..clipPath(hole);
    for (var i = 1; i < 3; i++) {
      final x = frame.left + frame.width * i / 3;
      final y = frame.top + frame.height * i / 3;
      canvas
        ..drawLine(Offset(x, frame.top), Offset(x, frame.bottom), g)
        ..drawLine(Offset(frame.left, y), Offset(frame.right, y), g);
    }
    canvas
      ..restore()
      ..drawPath(
        hole,
        Paint()
          ..color = line
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
  }

  @override
  bool shouldRepaint(_FramePainter old) => old.frame != frame || old.round != round || old.scrim != scrim;
}
