/// A person the signed-in user chose to block. Kept on this device only.
///
/// Projects and their comments identify people by user id, search and member
/// lists by μID, so both are stored when known and either one matches.
final class BlockedUser {
  /// A blocked person; at least one of [id] and [muid] should be set.
  const BlockedUser({required this.name, this.id, this.muid});

  /// Reads one entry written by [toJson].
  factory BlockedUser.fromJson(Map<String, dynamic> json) => BlockedUser(
    name: (json['name'] as String?) ?? '',
    id: json['id'] as String?,
    muid: json['muid'] as String?,
  );

  /// The user id the backend uses on projects and comments.
  final String? id;

  /// The public μID.
  final String? muid;

  /// Shown in the blocked list.
  final String name;

  /// Whether this entry is the person with [id] or [muid].
  bool matches({String? id, String? muid}) =>
      (id != null && id.isNotEmpty && this.id == id) ||
      (muid != null && muid.isNotEmpty && this.muid == muid);

  /// Merges what is known about the same person from two entries.
  BlockedUser merge(BlockedUser other) => BlockedUser(
    id: id ?? other.id,
    muid: muid ?? other.muid,
    name: name.isNotEmpty ? name : other.name,
  );

  /// For storage.
  Map<String, dynamic> toJson() => {'id': id, 'muid': muid, 'name': name};
}

/// Lookups on the blocked list used by screens that filter content.
extension BlockedUsersLookup on List<BlockedUser> {
  /// Whether the person with [id] or [muid] is blocked.
  bool blocks({String? id, String? muid}) =>
      any((b) => b.matches(id: id, muid: muid));
}
