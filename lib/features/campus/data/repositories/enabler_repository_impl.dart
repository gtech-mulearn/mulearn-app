import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/campus/data/dtos/enabler_dtos.dart';
import 'package:mulearn_app/features/campus/domain/entities/enabler.dart';
import 'package:mulearn_app/features/campus/domain/repositories/enabler_repository.dart';

class EnablerRepositoryImpl implements EnablerRepository {
  const EnablerRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<EnablerSummary> getSummary() => _guard(() async {
        final body = ApiEnvelope.unwrapObject(await _dio.get<dynamic>(EnablerPaths.homeSummary));
        int n(String k) => (body[k] as num?)?.toInt() ?? 0;
        return (campuses: n('total_campuses'), students: n('total_students'), karma: n('total_karma'));
      });

  @override
  Future<List<EnablerCampus>> getCampuses() => _guard(() async {
        final body = ApiEnvelope.unwrapObject(
          await _dio.get<dynamic>(EnablerPaths.campuses, queryParameters: {'pageIndex': 1, 'perPage': 100}),
        );
        return parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (j) => EnablerCampusDto.fromJson(j).toDomain(),
          what: 'EnablerCampusDto',
        );
      });

  @override
  Future<EnablerCampus> getCampus(String id) => _guard(() async =>
      EnablerCampusDto.fromJson(ApiEnvelope.unwrapObject(await _dio.get<dynamic>(EnablerPaths.campusReview(id)))).toDomain());

  @override
  Future<List<CampusNote>> getNotes(String campusId) => _guard(() async {
        final body = ApiEnvelope.unwrapObject(
          await _dio.get<dynamic>(EnablerPaths.campusNotes(campusId), queryParameters: {'pageIndex': 1, 'perPage': 50}),
        );
        return parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (j) => CampusNoteDto.fromJson(j).toDomain(),
          what: 'CampusNoteDto',
        );
      });

  @override
  Future<String> addNote(String campusId, {required String note, required String priority, DateTime? followUp}) =>
      _guard(() async {
        final response = await _dio.post<dynamic>(EnablerPaths.campusNotes(campusId), data: {
          'note': note,
          'priority': priority,
          if (followUp != null)
            'follow_up_date':
                '${followUp.year.toString().padLeft(4, '0')}-${followUp.month.toString().padLeft(2, '0')}-${followUp.day.toString().padLeft(2, '0')}',
        });
        return ApiEnvelope.unwrapMessage(response) ?? '';
      });

  @override
  Future<String> deleteNote(String campusId, String noteId) => _guard(() async {
        final response = await _dio.delete<dynamic>(EnablerPaths.campusNotes(campusId), data: {'note_id': noteId});
        return ApiEnvelope.unwrapMessage(response) ?? '';
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
