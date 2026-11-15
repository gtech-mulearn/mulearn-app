import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/paging.dart';

/// Raw Dio calls for jobs and the learner's applications, returning the
/// unwrapped `response`. Parsing happens in the repository.
class OpportunitiesRemoteDataSource {
  const OpportunitiesRemoteDataSource(this._dio);

  final Dio _dio;

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchJobs({
    required int pageIndex,
    String search = '',
  }) async => ApiEnvelope.unwrapObject(
    await _dio.get<dynamic>(
      ApiPaths.jobsAll,
      queryParameters: {
        ...PageIndexPaging.query(pageIndex),
        'sortBy': '-created_at',
        if (search.trim().isNotEmpty) 'search': search.trim(),
      },
    ),
  );

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchMyApplications({
    required int pageIndex,
  }) async => ApiEnvelope.unwrapObject(
    await _dio.get<dynamic>(
      ApiPaths.myJobApplications,
      queryParameters: {
        ...PageIndexPaging.query(pageIndex),
        'sortBy': '-applied_at',
      },
    ),
  );

  Future<void> apply(
    String jobId, {
    required String resumeLink,
    String? coverLetter,
  }) async => ApiEnvelope.unwrapMessage(
    await _dio.post<dynamic>(
      ApiPaths.jobApply(jobId),
      data: {
        'resume_link': resumeLink,
        if (coverLetter != null && coverLetter.isNotEmpty)
          'cover_letter': coverLetter,
      },
    ),
  );

  Future<void> resubmit(
    String applicationId, {
    required String resumeLink,
    String? coverLetter,
  }) async => ApiEnvelope.unwrapMessage(
    await _dio.patch<dynamic>(
      ApiPaths.jobApplicationResubmit(applicationId),
      data: {
        'resume_link': resumeLink,
        if (coverLetter != null && coverLetter.isNotEmpty)
          'cover_letter': coverLetter,
      },
    ),
  );

  Future<void> withdraw(String applicationId) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.delete<dynamic>(
          ApiPaths.jobApplicationWithdraw(applicationId),
        ),
      );
}
