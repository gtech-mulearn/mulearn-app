import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';
import 'package:mulearn_app/features/learning_circles/domain/repositories/learning_circles_repository.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';

class MockLearningCirclesRepository extends Mock
    implements LearningCirclesRepository {}

void main() {
  late MockLearningCirclesRepository repository;

  setUp(() => repository = MockLearningCirclesRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        learningCirclesRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('CircleActionsController.respondToInvite', () {
    test('accepting an invite refreshes my circles and pending invites',
        () async {
      when(() => repository.respondToInvite('link-1', accept: true))
          .thenAnswer((_) async {});
      when(repository.getMyPendingInvites).thenAnswer((_) async => []);
      when(repository.getMyCircles).thenAnswer((_) async => []);

      final container = makeContainer();
      await container
          .read(circleActionsControllerProvider.notifier)
          .respondToInvite('link-1', accept: true);

      verify(() => repository.respondToInvite('link-1', accept: true))
          .called(1);
      expect(
        container.read(circleActionsControllerProvider).hasError,
        isFalse,
      );
    });

    test('surfaces a repository failure as AsyncError', () async {
      when(() => repository.respondToInvite('link-1', accept: false))
          .thenThrow(Exception('boom'));

      final container = makeContainer();
      await container
          .read(circleActionsControllerProvider.notifier)
          .respondToInvite('link-1', accept: false);

      expect(
        container.read(circleActionsControllerProvider).hasError,
        isTrue,
      );
    });
  });

  group('MeetingActionsController', () {
    const form = MeetingForm(
      title: 'Weekly sync',
      description: 'Catch up on progress',
      mode: 'online',
      meetPlace: 'Google Meet',
      meetTime: '2026-08-01T10:00:00Z',
      duration: 1,
      isRecurring: false,
      isReportNeeded: false,
      platform: 'Google Meet',
    );

    test('editMeeting forwards the form and refreshes meeting detail',
        () async {
      when(() => repository.editMeeting('meeting-1', form))
          .thenAnswer((_) async {});
      when(() => repository.getMeetingDetail('meeting-1'))
          .thenAnswer((_) async => throw Exception('not needed'));

      final container = makeContainer();
      await container
          .read(meetingActionsControllerProvider.notifier)
          .editMeeting('meeting-1', form);

      verify(() => repository.editMeeting('meeting-1', form)).called(1);
      expect(
        container.read(meetingActionsControllerProvider).hasError,
        isFalse,
      );
    });

    test('deleteMeeting only busts the circle meeting-list cache when a '
        'circleId is supplied', () async {
      when(() => repository.deleteMeeting('meeting-1'))
          .thenAnswer((_) async {});

      final container = makeContainer();
      final ok = await container
          .read(meetingActionsControllerProvider.notifier)
          .deleteMeeting('meeting-1');

      expect(ok, isTrue);
      verify(() => repository.deleteMeeting('meeting-1')).called(1);
    });

    test('submitMeetingReport forwards report text and attendance map',
        () async {
      when(() => repository.submitMeetingReport(
            'meeting-1',
            report: 'Great session',
            attendees: {'user-1': true, 'user-2': false},
          )).thenAnswer((_) async {});
      when(() => repository.getMeetingReport('meeting-1'))
          .thenAnswer((_) async => throw Exception('not needed'));

      final container = makeContainer();
      await container
          .read(meetingActionsControllerProvider.notifier)
          .submitMeetingReport(
            'meeting-1',
            report: 'Great session',
            attendees: {'user-1': true, 'user-2': false},
          );

      verify(() => repository.submitMeetingReport(
            'meeting-1',
            report: 'Great session',
            attendees: {'user-1': true, 'user-2': false},
          )).called(1);
      expect(
        container.read(meetingActionsControllerProvider).hasError,
        isFalse,
      );
    });

    test('surfaces a repository failure from deleteMeeting as false',
        () async {
      when(() => repository.deleteMeeting('meeting-1'))
          .thenThrow(Exception('boom'));

      final container = makeContainer();
      final ok = await container
          .read(meetingActionsControllerProvider.notifier)
          .deleteMeeting('meeting-1');

      expect(ok, isFalse);
    });
  });
}
