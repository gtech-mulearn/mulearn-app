import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/presentation/providers/socials_controller.dart';

/// Full-replace edit of the user's social links, as a form sheet. Each
/// field takes a username or a full link (the profile accepts either).
class EditSocialsSheet extends ConsumerStatefulWidget {
  const EditSocialsSheet({required this.initial, super.key});

  final Socials initial;

  /// Opens the sheet over [context].
  static Future<void> show(BuildContext context, Socials initial) =>
      showMuSheet<void>(context, builder: (_) => EditSocialsSheet(initial: initial));

  @override
  ConsumerState<EditSocialsSheet> createState() => _EditSocialsSheetState();
}

/// Key, label, where the username goes.
const _fields = [
  ('github', 'GitHub', 'github.com/'),
  ('linkedin', 'LinkedIn', 'linkedin.com/in/'),
  ('instagram', 'Instagram', 'instagram.com/'),
  ('facebook', 'Facebook', 'facebook.com/'),
  ('dribble', 'Dribbble', 'dribbble.com/'),
  ('behance', 'Behance', 'behance.net/'),
  ('stackoverflow', 'Stack Overflow', 'stackoverflow.com/users/'),
  ('medium', 'Medium', 'medium.com/@'),
  ('hackerrank', 'HackerRank', 'hackerrank.com/'),
];

class _EditSocialsSheetState extends ConsumerState<EditSocialsSheet> {
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

  String _v(String key) => _controllers[key]!.text.trim();

  Future<void> _save() async {
    setState(() => _saving = true);
    final socials = Socials(
      github: _v('github'),
      linkedin: _v('linkedin'),
      instagram: _v('instagram'),
      facebook: _v('facebook'),
      dribble: _v('dribble'),
      behance: _v('behance'),
      stackoverflow: _v('stackoverflow'),
      medium: _v('medium'),
      hackerrank: _v('hackerrank'),
    );
    try {
      await ref.read(socialsControllerProvider.notifier).save(socials);
      if (mounted) {
        MuToast.show(context, message: 'Links saved', type: MuToastType.success);
        Navigator.of(context).pop();
      }
    } on Object catch (e) {
      if (mounted) {
        MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MuFormSheet(
      title: 'Social links',
      lead: 'Shown on your profile so peers and mentors can find your work.',
      action: MuButton(label: 'Save', block: true, loading: _saving, onPressed: _saving ? null : _save),
      children: [
        for (final (key, label, base) in _fields)
          MuTextField(
            label: label,
            controller: _controllers[key],
            hint: 'Username or link',
            help: '$base<username>',
            keyboardType: TextInputType.url,
            textInputAction: key == _fields.last.$1 ? TextInputAction.done : TextInputAction.next,
          ),
      ],
    );
  }
}
