import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/foundation/mu_avatar.dart';
import 'package:mulearn_app/core/design_system/foundation/mu_avatar_stack.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  test('initials and stable colours', () {
    expect(MuAvatar.initialsOf('Aysha Rahman'), 'AR');
    expect(MuAvatar.initialsOf('  nikhil  '), 'N');
    expect(MuAvatar.initialsOf(''), '');
    expect(MuTones.hashed('Aysha Rahman'), MuTones.hashed('aysha rahman'));
    expect(IgCategory.parse('Maker'), IgCategory.maker);
    expect(IgCategory.parse(null), IgCategory.others);
    expect(IgCategory.parse('unknown'), IgCategory.others);
  });

  test('peer sentences name the first two people', () {
    expect(
      MuPeerLine.sentence(
        ['Arjun J', 'Sneha M', 'Rahul'],
        11,
        scope: 'from CET',
      ),
      'Arjun, Sneha & 9 others from CET',
    );
    expect(
      MuPeerLine.sentence(['Arjun', 'Sneha'], 3),
      'Arjun, Sneha & 1 other',
    );
    expect(MuPeerLine.sentence(['Arjun', 'Sneha'], 2), 'Arjun and Sneha');
    expect(MuPeerLine.sentence([], 214), '214 people');
  });

  testWidgets(
    'avatar without a photo shows initials and its name to screen readers',
    (tester) async {
      await tester.pumpWidget(
        _host(const MuAvatar(name: 'Aysha Rahman', size: 40)),
      );
      expect(find.text('AR'), findsOneWidget);
      expect(find.bySemanticsLabel('Aysha Rahman'), findsOneWidget);
    },
  );

  testWidgets('stack shows three faces then +N', (tester) async {
    await tester.pumpWidget(
      _host(
        const MuAvatarStack(names: ['A B', 'C D', 'E F', 'G H'], extraCount: 5),
      ),
    );
    expect(find.byType(MuAvatar), findsNWidgets(3));
    expect(find.text('+6'), findsOneWidget);
    expect(find.bySemanticsLabel('9 people'), findsOneWidget);
  });

  testWidgets('an empty stack takes no space', (tester) async {
    await tester.pumpWidget(_host(const MuAvatarStack(names: [])));
    expect(tester.getSize(find.byType(MuAvatarStack)), Size.zero);
  });
}
