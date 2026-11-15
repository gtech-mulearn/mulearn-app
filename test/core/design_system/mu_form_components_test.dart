import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(
    body: Center(
      child: SizedBox(width: 340, child: SingleChildScrollView(child: child)),
    ),
  ),
);

void main() {
  group('MuTextField', () {
    testWidgets('validates on submit, then re-validates as the person types', (
      tester,
    ) async {
      final form = GlobalKey<FormState>();
      await tester.pumpWidget(
        _host(
          Form(
            key: form,
            child: MuTextField(
              label: 'Email',
              help: "We'll send a code to verify it.",
              validator: (v) => (v ?? '').contains('@')
                  ? null
                  : 'Enter an email like you@college.edu.',
            ),
          ),
        ),
      );
      expect(find.text("We'll send a code to verify it."), findsOneWidget);

      form.currentState!.validate();
      await tester.pump();
      expect(find.text('Enter an email like you@college.edu.'), findsOneWidget);
      expect(
        find.text("We'll send a code to verify it."),
        findsNothing,
        reason: 'the error replaces the help',
      );

      await tester.enterText(find.byType(TextField), 'aysha@cet.ac.in');
      await tester.pump();
      expect(
        find.text('Enter an email like you@college.edu.'),
        findsNothing,
        reason: 'fixed while typing',
      );
      expect(
        find.text('aysha@cet.ac.in'),
        findsOneWidget,
        reason: 'never clears the text',
      );
    });

    testWidgets('a server error shows until the text changes', (tester) async {
      await tester.pumpWidget(
        _host(const MuTextField(label: 'muid', error: 'This muid is taken.')),
      );
      expect(find.text('This muid is taken.'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'aysha2');
      await tester.pump();
      expect(find.text('This muid is taken.'), findsNothing);
    });

    testWidgets('a password can be shown and hidden', (tester) async {
      await tester.pumpWidget(
        _host(const MuTextField(label: 'Password', obscure: true)),
      );
      expect(
        tester.widget<TextField>(find.byType(TextField)).obscureText,
        isTrue,
      );
      await tester.tap(find.bySemanticsLabel('Show password'));
      await tester.pump();
      expect(
        tester.widget<TextField>(find.byType(TextField)).obscureText,
        isFalse,
      );
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
    });
  });

  group('MuSelectField', () {
    final colleges = [
      for (final name in [
        'CET Trivandrum',
        'GEC Thrissur',
        'TKM Kollam',
        'MEC Kochi',
        'NIT Calicut',
        'SJC Palai',
        'RIT Kottayam',
        'MBCET Trivandrum',
      ])
        MuOption(name.split(' ').first.toLowerCase(), name),
    ];

    testWidgets('opens a searchable sheet and reports the pick', (
      tester,
    ) async {
      String? picked;
      await tester.pumpWidget(
        _host(
          MuSelectField(
            label: 'College',
            options: colleges,
            onChanged: (v) => picked = v,
          ),
        ),
      );
      expect(find.text('Select'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('College, Select'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'thrissur');
      await tester.pump();
      expect(find.text('CET Trivandrum'), findsNothing);
      await tester.tap(find.text('GEC Thrissur'));
      await tester.pumpAndSettle();

      expect(picked, 'gec');
      expect(find.text('GEC Thrissur'), findsOneWidget);
    });

    testWidgets('offers "not listed" when allowed', (tester) async {
      String? picked;
      await tester.pumpWidget(
        _host(
          MuSelectField(
            label: 'College',
            options: colleges.take(3).toList(),
            allowOther: true,
            onChanged: (v) => picked = v,
          ),
        ),
      );
      await tester.tap(find.bySemanticsLabel('College, Select'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Not listed? Add it'));
      await tester.pumpAndSettle();
      expect(picked, muOtherOptionValue);
    });

    testWidgets('validates inside a form', (tester) async {
      final form = GlobalKey<FormState>();
      await tester.pumpWidget(
        _host(
          Form(
            key: form,
            child: MuSelectField(
              label: 'College',
              options: colleges,
              onChanged: (_) {},
              validator: (v) =>
                  v == null ? 'Pick your college to continue.' : null,
            ),
          ),
        ),
      );
      expect(form.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Pick your college to continue.'), findsOneWidget);
    });
  });

  testWidgets('MuOtpField completes on the last digit and takes a paste', (
    tester,
  ) async {
    String? done;
    await tester.pumpWidget(
      _host(
        MuOtpField(label: 'Code sent to you', onCompleted: (v) => done = v),
      ),
    );
    await tester.enterText(find.byType(TextField), '481');
    await tester.pump();
    expect(done, isNull);
    expect(find.text('4'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '481902');
    await tester.pump();
    expect(done, '481902');

    await tester.enterText(find.byType(TextField), '12a4567');
    await tester.pump();
    final text = tester
        .widget<TextField>(find.byType(TextField))
        .controller!
        .text;
    expect(text, '124567', reason: 'digits only, six at most');
  });

  group('selection controls', () {
    testWidgets('a switch row toggles from anywhere on the row', (
      tester,
    ) async {
      var on = false;
      await tester.pumpWidget(
        _host(
          StatefulBuilder(
            builder: (context, set) => MuSwitchTile(
              label: 'Task reviews',
              value: on,
              onChanged: (v) => set(() => on = v),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Task reviews'));
      await tester.pumpAndSettle();
      expect(on, isTrue);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Task reviews')),
        isSemantics(isToggled: true),
      );
    });

    testWidgets('radio cards pick one role', (tester) async {
      String? role = 'student';
      await tester.pumpWidget(
        _host(
          StatefulBuilder(
            builder: (context, set) => Column(
              children: [
                for (final r in ['student', 'mentor'])
                  MuRadioCard<String>(
                    value: r,
                    groupValue: role,
                    title: r == 'student' ? 'Student' : 'Mentor',
                    subtitle: r == 'student'
                        ? 'Learn and earn karma'
                        : 'Guide learners',
                    onChanged: (v) => set(() => role = v),
                  ),
              ],
            ),
          ),
        ),
      );
      await tester.tap(find.text('Mentor'));
      await tester.pumpAndSettle();
      expect(role, 'mentor');
      expect(
        tester.getSemantics(find.bySemanticsLabel('Mentor, Guide learners')),
        isSemantics(isChecked: true),
      );
      expect(
        tester.getSemantics(
          find.bySemanticsLabel('Student, Learn and earn karma'),
        ),
        isSemantics(isChecked: false),
      );
    });

    testWidgets('a checklist toggles its steps', (tester) async {
      var items = const [
        MuChecklistItem('Build it', done: true),
        MuChecklistItem('Push it'),
      ];
      await tester.pumpWidget(
        _host(
          StatefulBuilder(
            builder: (context, set) => MuChecklist(
              items: items,
              onToggle: (i) => set(() {
                items = [
                  for (var j = 0; j < items.length; j++)
                    if (j == i)
                      MuChecklistItem(items[j].label, done: !items[j].done)
                    else
                      items[j],
                ];
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Push it'));
      await tester.pump();
      expect(items[1].done, isTrue);
    });
  });

  testWidgets('loaders: skeleton waits 300ms; dots announce what is loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(const MuDelayed(child: MuSkeletonBox(width: 100))),
    );
    expect(find.byType(MuSkeletonBox), findsNothing);
    await tester.pump(const Duration(milliseconds: 320));
    expect(find.byType(MuSkeletonBox), findsOneWidget);

    await tester.pumpWidget(
      _host(const MuDotsLoader(label: 'Checking your code…')),
    );
    expect(find.bySemanticsLabel('Checking your code…'), findsOneWidget);
  });
}
