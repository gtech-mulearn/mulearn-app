import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';
import 'package:mulearn_app/features/problem_statements/domain/repositories/problem_statements_repository.dart';

/// `api/dashboard/problem_statement/urls.py`, learner side.
abstract final class ProblemStatementPaths {
  const ProblemStatementPaths._();

  static const String feed = '/api/v1/dashboard/problem-statements/';
  static String detail(String id) =>
      '/api/v1/dashboard/problem-statements/$id/';
  static String interaction(String id) =>
      '/api/v1/dashboard/problem-statements/$id/interaction/';
  static String submission(String id) =>
      '/api/v1/dashboard/problem-statements/$id/submission/';
}

class ProblemStatementsRemoteDataSource {
  const ProblemStatementsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchFeed(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          ProblemStatementPaths.feed,
          queryParameters: query,
        ),
      );

  Future<Map<String, dynamic>> fetchDetail(String id) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(ProblemStatementPaths.detail(id)),
      );

  Future<Map<String, dynamic>> fetchInteraction(String id) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(ProblemStatementPaths.interaction(id)),
      );

  Future<void> putInteraction(String id) => _dio.put<dynamic>(
    ProblemStatementPaths.interaction(id),
    data: {'status': 'Trying'},
  );

  Future<void> deleteInteraction(String id) =>
      _dio.delete<dynamic>(ProblemStatementPaths.interaction(id));

  Future<void> putSubmission(String id, String url) => _dio.put<dynamic>(
    ProblemStatementPaths.submission(id),
    data: {'submission_url': url},
  );

  Future<void> deleteSubmission(String id) =>
      _dio.delete<dynamic>(ProblemStatementPaths.submission(id));
}

/// Maps `ProblemStatementSerializer` and the interaction payload.
class ProblemStatementsRepositoryImpl implements ProblemStatementsRepository {
  const ProblemStatementsRepositoryImpl(this._remote);

  final ProblemStatementsRemoteDataSource _remote;

  /// The participating list reads the feed this many at a time.
  static const participatingPageSize = 100;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static int _int(Object? v) =>
      v is num ? v.toInt() : int.tryParse('${v ?? ''}') ?? 0;

  static DateTime? _time(Object? v) =>
      DateTime.tryParse(_str(v) ?? '')?.toLocal();

  static ProblemStatement? parse(Map<String, dynamic> json) {
    final id = _str(json['id']);
    if (id == null) return null;
    final company = json['company'] is Map<String, dynamic>
        ? json['company'] as Map<String, dynamic>
        : const <String, dynamic>{};
    final counts = json['interaction_counts'] is Map<String, dynamic>
        ? json['interaction_counts'] as Map<String, dynamic>
        : const <String, dynamic>{};
    final skills = json['skills'];
    return ProblemStatement(
      id: id,
      title: _str(json['title']) ?? 'Problem statement',
      description: _str(json['description']) ?? '',
      category: _str(json['category']),
      skills: skills is List ? [for (final s in skills) ?_str(s)] : const [],
      deadline: _time(json['deadline']),
      isOpen: json['is_open'] == true,
      companyName: _str(company['name']) ?? 'muLearn',
      companyLogo: _str(company['logo']),
      trying: _int(counts['Trying']),
      submitted: _int(counts['Submitted']),
      myStatus: PsStatus.parse(json['my_interaction']),
      publishedAt: _time(json['published_at']),
    );
  }

  static PsPage parsePage(Map<String, dynamic> json) {
    final data = json['data'];
    final rows = data is List
        ? data.whereType<Map<String, dynamic>>()
        : const <Map<String, dynamic>>[];
    final info = PageIndexPaging.parse(
      json['pagination'] as Map<String, dynamic>?,
    );
    return (
      items: [for (final r in rows) ?parse(r)],
      hasNext: info.hasNext,
      totalPages: info.totalPages,
    );
  }

  static MyPsParticipation parseParticipation(Map<String, dynamic> json) =>
      MyPsParticipation(
        status: PsStatus.parse(json['status']),
        submissionUrl: _str(json['submission_url']),
        submittedAt: _time(json['submitted_at']),
      );

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<PsPage> feed({
    String search = '',
    bool openOnly = false,
    int pageIndex = 1,
    int perPage = PageIndexPaging.defaultPerPage,
  }) => _guard(() async {
    final query = {
      ...PageIndexPaging.query(pageIndex, perPage: perPage),
      if (search.trim().isNotEmpty) 'search': search.trim(),
      if (openOnly) 'open_only': 'true',
    };
    return parsePage(await _remote.fetchFeed(query));
  });

  @override
  Future<List<ProblemStatement>> participating() => _guard(() async {
    final first = parsePage(
      await _remote.fetchFeed(
        PageIndexPaging.query(1, perPage: participatingPageSize),
      ),
    );
    final rest = await Future.wait([
      for (var p = 2; p <= first.totalPages; p++)
        _remote
            .fetchFeed(PageIndexPaging.query(p, perPage: participatingPageSize))
            .then(parsePage),
    ]);
    return [
      for (final page in [first, ...rest])
        for (final s in page.items)
          if (s.myStatus != null) s,
    ];
  });

  @override
  Future<ProblemStatement> detail(String id) => _guard(() async {
    final statement = parse(await _remote.fetchDetail(id));
    if (statement == null) {
      throw const ApiException(
        message: "This problem statement couldn't be read.",
      );
    }
    return statement;
  });

  @override
  Future<MyPsParticipation> myParticipation(String id) => _guard(
    () async => parseParticipation(await _remote.fetchInteraction(id)),
  );

  @override
  Future<void> startTrying(String id) =>
      _guard(() => _remote.putInteraction(id));

  @override
  Future<void> leave(String id) => _guard(() => _remote.deleteInteraction(id));

  @override
  Future<void> submit(String id, String url) =>
      _guard(() => _remote.putSubmission(id, url));

  @override
  Future<void> withdraw(String id) =>
      _guard(() => _remote.deleteSubmission(id));
}
