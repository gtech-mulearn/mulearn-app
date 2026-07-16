import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/presentation/providers/socials_controller.dart';

/// Full-replace edit form for the user's social links.
class EditSocialsDialog extends ConsumerStatefulWidget {
  const EditSocialsDialog({required this.initial, super.key});

  final Socials initial;

  @override
  ConsumerState<EditSocialsDialog> createState() => _EditSocialsDialogState();
}

class _EditSocialsDialogState extends ConsumerState<EditSocialsDialog> {
  late final Map<String, TextEditingController> _controllers = {
    'github': TextEditingController(text: widget.initial.github),
    'linkedin': TextEditingController(text: widget.initial.linkedin),
    'instagram': TextEditingController(text: widget.initial.instagram),
    'facebook': TextEditingController(text: widget.initial.facebook),
    'dribble': TextEditingController(text: widget.initial.dribble),
    'behance': TextEditingController(text: widget.initial.behance),
    'stackoverflow': TextEditingController(text: widget.initial.stackoverflow),
    'medium': TextEditingController(text: widget.initial.medium),
    'hackerrank': TextEditingController(text: widget.initial.hackerrank),
  };
  bool _saving = false;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final socials = Socials(
      github: _controllers['github']!.text.trim(),
      linkedin: _controllers['linkedin']!.text.trim(),
      instagram: _controllers['instagram']!.text.trim(),
      facebook: _controllers['facebook']!.text.trim(),
      dribble: _controllers['dribble']!.text.trim(),
      behance: _controllers['behance']!.text.trim(),
      stackoverflow: _controllers['stackoverflow']!.text.trim(),
      medium: _controllers['medium']!.text.trim(),
      hackerrank: _controllers['hackerrank']!.text.trim(),
    );
    try {
      await ref.read(socialsControllerProvider.notifier).save(socials);
      if (mounted) Navigator.of(context).pop();
    } on Object catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ApiException.messageFor(e))));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit social links'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in _controllers.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: entry.key),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
