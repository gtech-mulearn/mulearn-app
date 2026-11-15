import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/opportunities/data/dtos/job_dto.dart';
import 'package:mulearn_app/features/opportunities/domain/entities/job.dart';
import 'package:mulearn_app/features/opportunities/presentation/screens/opportunities_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

const _jobs = '/api/v1/dashboard/company/jobs/all/';
const _mine = '/api/v1/dashboard/company/applications/me/';

/// Built from JobListSerializer / UserAppliedJobsSerializer
/// (api/dashboard/company/job_serializers.py:179, :338): dev had no jobs.
Map<String, dynamic> _job(String id, {required bool eligible, String title = 'Frontend Intern'}) => {
  'id': id,
  'company_name': 'Acme Labs',
  'company_logo': null,
  'title': title,
  'experience': '0-1 years',
  'job_description': 'Build the dashboard with us.',
  'location': 'Remote',
  'salary_range': null,
  'job_type': 'Internship',
  'status': 'Active',
  'duration_value': 3,
  'duration_unit': 'months',
  'hourly_rate': '250.00',
  'deliverables': [
    'A shipped feature',
    {'title': 'A write-up'},
  ],
  'stipend': '10k/month',
  'certificate_provided': 'Yes',
  'rules': <Object>[],
  'eligibility': {
    'eligible': eligible,
    'rules': [
      {
        'rule_type': 'min_karma',
        'rule_value': '500',
        'met': eligible,
        'message': eligible ? null : 'Insufficient Karma. Minimum 500 required.',
      },
    ],
  },
  'created_at': '2026-11-10T10:00:00Z',
  'expires_at': '2026-12-01T00:00:00Z',
};

Map<String, dynamic> _envelope(Object response) => {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': response,
};

Map<String, dynamic> _page(List<Object> rows) => _envelope({
  'data': rows,
  'pagination': {'count': rows.length, 'totalPages': 1, 'isNext': false, 'isPrev': false, 'nextPage': null},
});

void main() {
  test('a job maps its loose fields: certificate, deliverables, eligibility', () {
    final j = JobDto.job(_job('j1', eligible: false));

    expect(j.certificateProvided, isTrue);
    expect(j.deliverables, ['A shipped feature', 'A write-up']);
    expect(j.hourlyRate, '250.00');
    expect(j.eligible, isFalse);
    expect(j.checks.single.message, 'Insufficient Karma. Minimum 500 required.');
    expect(ApplicationStatus.parse('In-Review'), ApplicationStatus.inReview);
    expect(ApplicationStatus.rejected.canResubmit, isTrue);
    expect(ApplicationStatus.selected.canWithdraw, isFalse);
  });

  Future<void> pump(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(
      retry: (_, _) => null,
      overrides: [dioProvider.overrideWithValue(fakeDio(adapterRef!)), tokenStorageProvider.overrideWithValue(tokens)],
    );
    addTearDown(c.dispose);
    tester.view.physicalSize = const Size(1080, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(theme: MuThemeData.light(), home: const OpportunitiesScreen()),
      ),
    );
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('nothing posted says so', (tester) async {
    adapterRef = FakeHttpAdapter({
      'GET $_jobs': (_) => FakeResponse(200, _page([])),
      'GET $_mine': (_) => FakeResponse(200, _page([])),
    });
    await pump(tester);

    expect(find.text('No openings right now'), findsOneWidget);
  });

  testWidgets('apply sends the resume as a full link', (tester) async {
    adapterRef = FakeHttpAdapter({
      'GET $_jobs': (_) =>
          FakeResponse(200, _page([_job('j1', eligible: true), _job('j2', eligible: false, title: 'Data Fellow')])),
      'GET $_mine': (_) => FakeResponse(200, _page([])),
      'POST /api/v1/dashboard/company/jobs/j1/apply/': (_) => FakeResponse(200, _envelope(<String, dynamic>{})),
    });
    await pump(tester);

    expect(find.text('Frontend Intern'), findsOneWidget);
    expect(find.text('Not eligible yet'), findsOneWidget, reason: 'Data Fellow needs 500 karma');

    await tester.tap(find.text('Frontend Intern'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }
    expect(find.text('YOU QUALIFY'), findsOneWidget);
    await tester.tap(find.widgetWithText(MuButton, 'Apply'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.enterText(find.widgetWithText(MuTextField, 'Resume link'), 'drive.google.com/me');
    await tester.tap(find.text('Send application'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }

    final post = adapterRef!.requests.singleWhere((RequestOptions r) => r.method == 'POST');
    expect(post.data, {'resume_link': 'https://drive.google.com/me'});
    await tester.pump(const Duration(seconds: 5)); // let the toast leave
  });

  testWidgets('an application shows where it stands and can be withdrawn', (tester) async {
    adapterRef = FakeHttpAdapter({
      'GET $_jobs': (_) => FakeResponse(200, _page([_job('j1', eligible: true)])),
      'GET $_mine': (_) => FakeResponse(
        200,
        _page([
          {
            'id': 'a1',
            'job': _job('j1', eligible: true),
            'resume_link': 'https://x.dev',
            'cover_letter': null,
            'status': 'Shortlisted',
            'rejection_reason': null,
            'applied_at': '2026-11-12T09:00:00Z',
          },
        ]),
      ),
      'DELETE /api/v1/dashboard/company/applications/a1/withdraw/': (_) =>
          FakeResponse(200, _envelope(<String, dynamic>{})),
    });
    await pump(tester);

    expect(find.text('Shortlisted'), findsOneWidget, reason: 'the browse row shows the status');
    await tester.tap(find.text('Applied · 1'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.tap(find.text('Frontend Intern'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.tap(find.text('Withdraw application'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.tap(find.widgetWithText(MuButton, 'Withdraw'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }

    expect(adapterRef!.requests.where((RequestOptions r) => r.method == 'DELETE'), hasLength(1));
    await tester.pump(const Duration(seconds: 5));
  });
}

FakeHttpAdapter? adapterRef;
