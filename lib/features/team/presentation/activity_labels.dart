import 'dart:convert';

import 'package:mulearn_app/core/utils/count_format.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/presentation/campaign_labels.dart';

/// The `entity_name` of rows about a push campaign.
const String kCampaignEntity = 'push_campaign';

/// Longest a recorded value reads before it is cut.
const int _maxValueLength = 160;

/// How many titles a delete-all lists before "and N more".
const int _deleteAllTitles = 5;

/// "Asha Nair (Admin + Fellow)", without the brackets when no role is known.
String activityWho(ActivityEntry e) {
  final name = e.actorName;
  if (e.roles.isEmpty) return name;
  return '$name (${rolesLabel(e.roles, separator: ' + ')})';
}

/// "4,120 people" or "1 person", else the recorded label, else null.
String? activityAudience(ActivityEntry e) {
  final size = e.audienceSize;
  if (size != null) return countOf(size, 'person', 'people');
  final label = e.audienceLabel;
  return label == null || label.isEmpty ? null : label;
}

/// The line under a row's label: who, what and for whom, with the parts that
/// are missing left out.
String activityRowBody(ActivityEntry e) {
  final who = activityWho(e).trim();
  return [
    if (who.isNotEmpty) who,
    e.title ?? '—',
    ?activityAudience(e),
  ].join(' · ');
}

/// The "What changed" lines of an entry; empty when nothing was recorded.
List<String> activityChangeLines(ActivityEntry e) {
  final before = e.oldData ?? const <String, Object?>{};
  final after = e.newData ?? const <String, Object?>{};
  if (e.action == 'NOTIF_BROADCAST_DEL_ALL') return _deleteAllLines(before);
  if (e.action == 'PUSH_TEST_SEND') return _testPushLines(after);
  if (before.isEmpty && after.isEmpty) return const [];
  if (before.isEmpty) {
    return [for (final k in after.keys) '${_key(k)}: ${_value(k, after[k])}'];
  }
  if (after.isEmpty) {
    return [
      for (final k in before.keys)
        'Deleted: ${_key(k)}: ${_value(k, before[k])}',
    ];
  }
  return [
    for (final k in {...before.keys, ...after.keys})
      if (_encode(before[k]) != _encode(after[k]))
        '${_key(k)}: ${_changed(before, k)} → ${_changed(after, k)}',
  ];
}

String _changed(Map<String, Object?> data, String key) =>
    data.containsKey(key) ? _value(key, data[key]) : '—';

List<String> _deleteAllLines(Map<String, Object?> old) {
  final count = (old['count'] as num?)?.toInt();
  final items = old['items'];
  final titles = [
    if (items is List)
      for (final item in items)
        if (item is Map && item['title'] is String) item['title']! as String,
  ];
  final shown = titles.take(_deleteAllTitles).toList();
  final total = count ?? titles.length;
  return [
    if (count != null) 'Deleted ${countOf(count, 'announcement')}',
    for (final t in shown) '• $t',
    if (shown.isNotEmpty && total > shown.length)
      'and ${formatCount(total - shown.length)} more',
  ];
}

List<String> _testPushLines(Map<String, Object?> data) {
  final lines = <String>[
    for (final k in data.keys)
      if (k != 'outcome') '${_key(k)}: ${_value(k, data[k])}',
  ];
  if (data.containsKey('outcome')) {
    final outcome = data['outcome'];
    final sent = outcome is Map ? (outcome['sent'] as num?)?.toInt() ?? 0 : 0;
    lines.add(sent > 0 ? 'Sent to ${countOf(sent, 'device')}' : 'No device');
  }
  return lines;
}

const _names = <String, String>{
  'title': 'Title',
  'description': 'Message',
  'body': 'Message',
  'url': 'Opens',
  'redirect_url': 'Opens',
  'route': 'Opens',
};

/// A recorded key as a label: "Opens", "Target type".
String _key(String key) {
  final known = _names[key];
  if (known != null) return known;
  final words = key.replaceAll('_', ' ').trim();
  return words.isEmpty ? key : '${words[0].toUpperCase()}${words.substring(1)}';
}

const _timeKeys = {'expires_at', 'scheduled_at', 'created_at'};

/// A recorded value on one line: times in local time, yes/no for flags,
/// anything structured as JSON, all cut at 160 characters.
String _value(String key, Object? v) {
  final text = switch (v) {
    null => '—',
    final bool b => b ? 'Yes' : 'No',
    final String s when _timeKeys.contains(key) => _time(s),
    final String s => s,
    final num n => '$n',
    _ => jsonEncode(v),
  };
  return text.length > _maxValueLength
      ? '${text.substring(0, _maxValueLength)}…'
      : text;
}

String _time(String iso) {
  final parsed = DateTime.tryParse(iso);
  return parsed == null ? iso : formatDayTime(parsed.toLocal());
}

String _encode(Object? v) => jsonEncode(v);
