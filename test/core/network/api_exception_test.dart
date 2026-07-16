import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';

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
}
