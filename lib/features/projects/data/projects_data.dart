import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/features/projects/domain/entities/project.dart';
import 'package:mulearn_app/features/projects/domain/repositories/projects_repository.dart';

/// `api/dashboard/projects/urls.py` and the skill list.
abstract final class ProjectPaths {
  const ProjectPaths._();

  static const _base = '/api/v1/dashboard/projects';
  static const String list = '$_base/';
  static String detail(String id) => '$_base/$id/';
  static String status(String id) => '$_base/$id/status/';
  static String members(String id) => '$_base/$id/members/';
  static String member(String id, String memberId) => '$_base/$id/members/$memberId/';
  static const String vote = '$_base/vote/';
  static String voteById(String id) => '$_base/vote/$id/';
  static const String comment = '$_base/comment/';
  static String commentById(String id) => '$_base/comment/$id/';
  static const String skills = '/api/v1/dashboard/skill/';
  static const String people = '/api/v1/dashboard/user/search/';
}

/// Feed page size; "Yours" reads one page of [_mine].
const projectsPerPage = 12;
const _mine = 50;

class ProjectsRemoteDataSource {
  const ProjectsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> list(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ProjectPaths.list, queryParameters: query));

  Future<Map<String, dynamic>> detail(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ProjectPaths.detail(id)));

  Future<Map<String, dynamic>> save(String? id, FormData form) async => ApiEnvelope.unwrapObject(
    id == null
        ? await _dio.post<dynamic>(ProjectPaths.list, data: form)
        : await _dio.put<dynamic>(ProjectPaths.detail(id), data: form),
  );

  Future<void> delete(String id) => _dio.delete<dynamic>(ProjectPaths.detail(id));

  Future<void> status(String id, String status) =>
      _dio.patch<dynamic>(ProjectPaths.status(id), data: {'status': status});

  Future<void> addMember(String id, Map<String, Object> body) =>
      _dio.post<dynamic>(ProjectPaths.members(id), data: body);

  Future<void> removeMember(String id, String memberId) => _dio.delete<dynamic>(ProjectPaths.member(id, memberId));

  Future<void> vote(String projectId) =>
      _dio.post<dynamic>(ProjectPaths.vote, data: {'project': projectId, 'vote': 'upvote'});

  Future<void> deleteVote(String id) => _dio.delete<dynamic>(ProjectPaths.voteById(id));

  Future<void> comment(String projectId, String text) =>
      _dio.post<dynamic>(ProjectPaths.comment, data: {'project': projectId, 'comment': text});

  Future<void> deleteComment(String id) => _dio.delete<dynamic>(ProjectPaths.commentById(id));

  Future<Map<String, dynamic>> people(String query) async => ApiEnvelope.unwrapObject(
    await _dio.get<dynamic>(
      ProjectPaths.people,
      queryParameters: {'search': query, ...PageIndexPaging.query(1, perPage: 10)},
    ),
  );

  Future<Map<String, dynamic>> skills() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ProjectPaths.skills, queryParameters: {'perPage': 200}));
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  const ProjectsRepositoryImpl(this._remote);

  final ProjectsRemoteDataSource _remote;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static Iterable<Map<String, dynamic>> _maps(Object? v) =>
      v is List ? v.whereType<Map<String, dynamic>>() : const <Map<String, dynamic>>[];

  static Project? parse(Map<String, dynamic> j) {
    final id = _str(j['id']);
    if (id == null) return null;
    final links = [for (final l in _maps(j['links'])) l]
      ..sort((a, b) => ((a['position'] as num?) ?? 0).compareTo((b['position'] as num?) ?? 0));
    return Project(
      id: id,
      title: _str(j['title']) ?? 'Untitled project',
      description: _str(j['description']) ?? '',
      status: ProjectStatus.parse(j['status']),
      ownerName: _str(j['created_by']) ?? 'A μLearner',
      ownerId: _str(j['created_by_id']),
      ownerMuid: _str(j['created_by_muid']),
      createdAt: DateTime.tryParse(_str(j['created_at']) ?? '')?.toLocal() ?? DateTime.fromMillisecondsSinceEpoch(0),
      logoUrl: _str(j['logo']),
      images: [for (final i in _maps(j['images'])) ?_str(i['image'])],
      links: [
        for (final l in links)
          if (_str(l['url']) != null) (label: _str(l['label']) ?? _str(l['url'])!, url: _str(l['url'])!),
      ],
      skills: [
        for (final s in _maps(j['skills']))
          if (_str(s['id']) != null) (id: _str(s['id'])!, name: _str(s['name']) ?? ''),
      ],
      members: [
        for (final m in _maps(j['members']))
          if (_str(m['id']) != null)
            ProjectMember(
              id: _str(m['id'])!,
              name: _str(m['full_name']) ?? _str(m['external_name']) ?? 'Member',
              muid: m['is_linked'] == true ? _str(m['muid']) : null,
              photoUrl: _str(m['profile_pic']),
              role: _str(m['role']),
            ),
      ],
      votes: [
        for (final v in _maps(j['votes']))
          if (_str(v['id']) != null) (id: _str(v['id'])!, up: v['vote'] == 'upvote', userId: _str(v['user_id'])),
      ],
      comments: [
        for (final c in _maps(j['comments']))
          if (_str(c['id']) != null && _str(c['comment']) != null)
            ProjectComment(
              id: _str(c['id'])!,
              text: _str(c['comment'])!,
              authorName: _str(c['user']) ?? 'A μLearner',
              authorId: _str(c['user_id']),
              at: DateTime.tryParse(_str(c['created_at']) ?? '')?.toLocal() ?? DateTime.fromMillisecondsSinceEpoch(0),
            ),
      ]..sort((a, b) => a.at.compareTo(b.at)),
    );
  }

  /// `{data: {Projects: [...]}, pagination}`.
  static ProjectPage parsePage(Map<String, dynamic> json) {
    final data = json['data'];
    final rows = data is Map<String, dynamic> ? data['Projects'] : null;
    return (
      items: [for (final r in _maps(rows)) ?parse(r)],
      hasNext: PageIndexPaging.parse(json['pagination'] as Map<String, dynamic>?).hasNext,
    );
  }

  static FormData form(ProjectDraft d) => FormData.fromMap({
    'title': d.title,
    'description': d.description,
    'status': d.status.wire,
    'links_json': jsonEncode([
      for (final l in d.links) {'label': l.label, 'url': l.url},
    ]),
    'skill_ids_json': jsonEncode(d.skillIds),
    if (d.logo != null) 'logo': MultipartFile.fromBytes(d.logo!.bytes, filename: d.logo!.name),
    if (d.images.isNotEmpty) 'images': [for (final i in d.images) MultipartFile.fromBytes(i.bytes, filename: i.name)],
  }, ListFormat.multiCompatible);

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Project _one(Map<String, dynamic> json) {
    final p = json['Project'];
    final project = p is Map<String, dynamic> ? parse(p) : null;
    if (project == null) throw const ApiException(message: "This project couldn't be read.");
    return project;
  }

  @override
  Future<ProjectPage> feed({String search = '', int pageIndex = 1}) => _guard(
    () async => parsePage(
      await _remote.list({
        ...PageIndexPaging.query(pageIndex, perPage: projectsPerPage),
        if (search.trim().isNotEmpty) 'search': search.trim(),
      }),
    ),
  );

  @override
  Future<List<Project>> byMember(String muid) => _guard(
    () async => parsePage(await _remote.list({'muid': muid, ...PageIndexPaging.query(1, perPage: _mine)})).items,
  );

  @override
  Future<Project> detail(String id) => _guard(() async => _one(await _remote.detail(id)));

  @override
  Future<Project> create(ProjectDraft draft) => _guard(() async => _one(await _remote.save(null, form(draft))));

  @override
  Future<Project> update(String id, ProjectDraft draft) =>
      _guard(() async => _one(await _remote.save(id, form(draft))));

  @override
  Future<void> delete(String id) => _guard(() => _remote.delete(id));

  @override
  Future<void> setStatus(String id, ProjectStatus status) => _guard(() => _remote.status(id, status.wire));

  @override
  Future<void> addMember(String projectId, {String? muid, String? externalName, String? role}) => _guard(
    () => _remote.addMember(projectId, {
      if (muid != null) 'muid': muid else 'external_name': externalName ?? '',
      if ((role ?? '').trim().isNotEmpty) 'role': role!.trim(),
    }),
  );

  @override
  Future<void> removeMember(String projectId, String memberId) =>
      _guard(() => _remote.removeMember(projectId, memberId));

  @override
  Future<void> upvote(String projectId) => _guard(() => _remote.vote(projectId));

  @override
  Future<void> removeVote(String voteId) => _guard(() => _remote.deleteVote(voteId));

  @override
  Future<void> comment(String projectId, String text) => _guard(() => _remote.comment(projectId, text));

  @override
  Future<void> deleteComment(String commentId) => _guard(() => _remote.deleteComment(commentId));

  /// `{skills: [{id, name, …}], pagination}`.
  static List<ProjectSkill> parseSkills(Map<String, dynamic> json) => [
    for (final s in _maps(json['skills']))
      if (_str(s['id']) != null && _str(s['name']) != null) (id: _str(s['id'])!, name: _str(s['name'])!),
  ];

  /// `user/search/`: `{data: [{muid, full_name, profile_pic, …}], pagination}`.
  static List<ProjectMember> parsePeople(Map<String, dynamic> json) => [
    for (final u in _maps(json['data']))
      if (_str(u['muid']) != null)
        ProjectMember(
          id: _str(u['muid'])!,
          name: _str(u['full_name']) ?? _str(u['muid'])!,
          muid: _str(u['muid']),
          photoUrl: _str(u['profile_pic']),
        ),
  ];

  @override
  Future<List<ProjectMember>> findPeople(String query) => _guard(() async => parsePeople(await _remote.people(query)));

  @override
  Future<List<ProjectSkill>> skills() => _guard(() async => parseSkills(await _remote.skills()));
}
