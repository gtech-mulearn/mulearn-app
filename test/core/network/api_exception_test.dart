import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';

import '../../support/fixtures.dart';

void main() {
  RequestOptions req() => RequestOptions(path: '/x');

  group('ApiException.fromDioException', () {
    test('maps timeouts to a network error', () {
      final e = ApiException.fromDioException(
        DioException(
          requestOptions: req(),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      expect(e.isNetworkError, isTrue);
    });

    test('parses envelope message.general list', () {
      final e = ApiException.fromDioException(
        DioException(
          requestOptions: req(),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: req(),
            statusCode: 400,
            data: {
              'hasError': true,
              'statusCode': 400,
              'message': {
                'general': ['Invalid credentials.'],
              },
            },
          ),
        ),
      );
      expect(e.message, 'Invalid credentials.');
      expect(e.statusCode, 400);
    });

    // Final review, Important 2: a ValidationError raised inside a
    // serializer's create() (MentorAddParticipantSerializer) reaches DRF's
    // default handler, which answers with a bare list of strings.
    test('a bare DRF list body becomes the message', () {
      final e = ApiException.fromDioException(
        DioException(
          requestOptions: req(),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: req(),
            statusCode: 400,
            data: ['User with this muid not found or is suspended.'],
          ),
        ),
      );
      expect(e.message, 'User with this muid not found or is suspended.');
      expect(e.statusCode, 400);
      expect(e.kind, ApiErrorKind.validation);
    });

    test('several list messages are kept, one per line', () {
      final e = ApiException.fromDioException(
        DioException(
          requestOptions: req(),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(requestOptions: req(), statusCode: 400, data: ['First.', 'Second.']),
        ),
      );
      expect(e.message, 'First.\nSecond.');
    });

    test('parses DRF field-keyed validation errors', () {
      final e = ApiException.fromDioException(
        DioException(
          requestOptions: req(),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: req(),
            statusCode: 400,
            data: {
              'email': ['This field is required.'],
            },
          ),
        ),
      );
      expect(e.fieldErrors['email'], ['This field is required.']);
      expect(e.errorFor('email'), 'This field is required.');
    });

    test(
        'flattens field errors nested inside message under the request '
        "body's own key (e.g. POST /api/v1/register/'s nested `user` object) "
        '— confirmed directly against https://dev.mulearn.org', () {
      final e = ApiException.fromDioException(
        DioException(
          requestOptions: req(),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: req(),
            statusCode: 400,
            data: {
              'hasError': true,
              'statusCode': 400,
              'message': {
                'general': <String>[],
                'user': {
                  'full_name': ['This field may not be blank.'],
                  'email': ['Enter a valid email address.'],
                },
              },
              'response': <String, dynamic>{},
            },
          ),
        ),
      );
      expect(e.errorFor('full_name'), 'This field may not be blank.');
      expect(e.errorFor('email'), 'Enter a valid email address.');
    });
  });

  // Several backend views return serializer errors under `response`, not
  // `message` (`CustomResponse(response=serializer.errors)` — profile PATCH,
  // ig-edit, user/organization, qseverse).
  group('ApiException.fromEnvelopeBody with errors under response', () {
    test('uses a response field error when message carries nothing', () {
      final e = ApiException.fromEnvelopeBody({
        'hasError': true,
        'statusCode': 400,
        'message': {'general': <String>[]},
        'response': {
          'interest_group': ['Cannot select more than 3 interest groups'],
        },
      });

      expect(e.message, 'Cannot select more than 3 interest groups');
      expect(e.errorFor('interest_group'), 'Cannot select more than 3 interest groups');
      expect(e.statusCode, 400);
    });

    test('flattens nested response field errors to the leaf field', () {
      final e = ApiException.fromEnvelopeBody({
        'hasError': true,
        'statusCode': 400,
        'message': {'general': <String>[]},
        'response': {
          'user': {
            'email': ['Enter a valid email address.'],
          },
        },
      });

      expect(e.errorFor('email'), 'Enter a valid email address.');
    });

    test('message.general still wins over response field errors', () {
      final e = ApiException.fromEnvelopeBody({
        'hasError': true,
        'statusCode': 400,
        'message': {
          'general': ['Interest Group not found or inactive'],
        },
        'response': {
          'interest_group': ['ignored'],
        },
      });

      expect(e.message, 'Interest Group not found or inactive');
    });

    test('parses the error recorded live from PATCH /dashboard/profile/', () {
      final e = ApiException.fromEnvelopeBody(
        loadFixture('dev/profile_patch_invalid_email'),
      );

      expect(e.errorFor('email'), 'Enter a valid email address.');
      expect(e.message, 'Enter a valid email address.');
    });

    test('ignores plain data strings under response (only DRF list leaves are errors)', () {
      final e = ApiException.fromEnvelopeBody({
        'hasError': true,
        'statusCode': 400,
        'message': {'general': <String>[]},
        'response': {'circle_id': '3f2a9c1e-0000-4000-8000-000000000000'},
      });

      expect(e.message, 'Request failed (400).');
      expect(e.fieldErrors, isEmpty);
    });

    test('falls back to a generic message when nothing explains the error', () {
      final e = ApiException.fromEnvelopeBody({
        'hasError': true,
        'statusCode': 400,
        'message': {'general': <String>[]},
        'response': <dynamic>[],
      });

      expect(e.message, 'Request failed (400).');
    });
  });

  group('ApiException.kind', () {
    ApiException fromStatus(int status) => ApiException.fromEnvelopeBody({
          'hasError': true,
          'statusCode': status,
          'message': {'general': ['x']},
          'response': <String, dynamic>{},
        });

    test('a timeout is a timeout (and still a network error)', () {
      final e = ApiException.fromDioException(
        DioException(requestOptions: req(), type: DioExceptionType.connectionTimeout),
      );
      expect(e.kind, ApiErrorKind.timeout);
      expect(e.isNetworkError, isTrue);
    });

    test('no connection is a network error', () {
      final e = ApiException.fromDioException(
        DioException(requestOptions: req(), type: DioExceptionType.connectionError),
      );
      expect(e.kind, ApiErrorKind.network);
    });

    test('status codes map to their kinds', () {
      expect(fromStatus(401).kind, ApiErrorKind.unauthorized);
      expect(fromStatus(403).kind, ApiErrorKind.forbidden);
      expect(fromStatus(404).kind, ApiErrorKind.notFound);
      expect(fromStatus(500).kind, ApiErrorKind.server);
      expect(fromStatus(502).kind, ApiErrorKind.server);
    });

    test('field errors recorded live are a validation error', () {
      final e = ApiException.fromEnvelopeBody(loadFixture('dev/profile_patch_invalid_email'));
      expect(e.kind, ApiErrorKind.validation);
    });

    test('an error with nothing to classify is unknown', () {
      expect(const ApiException(message: 'x').kind, ApiErrorKind.unknown);
    });
  });
}
