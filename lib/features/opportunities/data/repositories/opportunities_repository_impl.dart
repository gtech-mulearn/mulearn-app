import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/features/opportunities/data/datasources/opportunities_remote_datasource.dart';
import 'package:mulearn_app/features/opportunities/data/dtos/job_dto.dart';
import 'package:mulearn_app/features/opportunities/domain/entities/job.dart';
import 'package:mulearn_app/features/opportunities/domain/repositories/opportunities_repository.dart';

class OpportunitiesRepositoryImpl implements OpportunitiesRepository {
  const OpportunitiesRepositoryImpl(this._remote);

  final OpportunitiesRemoteDataSource _remote;

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  static OpportunityPage<T> _page<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) map) {
    final info = PageIndexPaging.parse(json['pagination'] as Map<String, dynamic>?);
    return OpportunityPage(
      items: [
        for (final row in (json['data'] as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>()) map(row),
      ],
      hasNext: info.hasNext,
      count: info.count,
    );
  }

  @override
  Future<OpportunityPage<Job>> jobs({required int pageIndex, String search = ''}) =>
      _guard(() async => _page(await _remote.fetchJobs(pageIndex: pageIndex, search: search), JobDto.job));

  @override
  Future<OpportunityPage<JobApplication>> myApplications({required int pageIndex}) =>
      _guard(() async => _page(await _remote.fetchMyApplications(pageIndex: pageIndex), JobDto.application));

  @override
  Future<void> apply(String jobId, {required String resumeLink, String? coverLetter}) =>
      _guard(() => _remote.apply(jobId, resumeLink: resumeLink, coverLetter: coverLetter));

  @override
  Future<void> resubmit(String applicationId, {required String resumeLink, String? coverLetter}) =>
      _guard(() => _remote.resubmit(applicationId, resumeLink: resumeLink, coverLetter: coverLetter));

  @override
  Future<void> withdraw(String applicationId) => _guard(() => _remote.withdraw(applicationId));
}
