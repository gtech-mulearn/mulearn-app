import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/editable_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/achievements_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_karma_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_sheet.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/share_profile_dialog.dart';

enum _Section { karma, achievements }

/// A profile, own or someone else's (artifact: Screen patterns → User
/// profiles): the poster hero, the night sheet over it with who they are,
/// then Karma or Achievements under a switch that pins below the status bar.
///
/// One scroll for the whole page: the sections are plain columns, so there
/// are no nested scroll views to overlap or to size by hand.
class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({required this.profile, this.isOwn = true, super.key});

  final UserProfile profile;
  final bool isOwn;

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  _Section _section = _Section.karma;
  final _heroKey = GlobalKey();
  final _topKey = GlobalKey();

  /// Once the hero has scrolled under the status bar, a `night` backdrop
  /// fades in behind the status bar so the sheet never slides under the
  /// clock.
  bool _underStatusBar = false;

  /// Space above the section switch: section spacing at rest, growing to
  /// the status-bar height as the switch reaches the top and pins.
  double _barPad = MuSpacing.space4;

  bool _onScroll(ScrollNotification n, double top) {
    if (n.depth != 0) return false;
    final hero = _heroKey.currentContext?.size?.height ?? 300;
    // Hero + sheet; past it the pinned section bar paints its own band.
    final both = _topKey.currentContext?.size?.height ?? double.infinity;
    final y = n.metrics.pixels;
    final under = y > hero - top && y < both - top;
    // Where the switch sits relative to the screen top, before it pins.
    final switchTop = both - y;
    final pad = (top - switchTop.clamp(0.0, top)).clamp(MuSpacing.space4, top);
    if (under != _underStatusBar || (pad - _barPad).abs() > 0.5) {
      setState(() {
        _underStatusBar = under;
        _barPad = pad;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final isOwn = widget.isOwn;
    final top = MediaQuery.paddingOf(context).top;
    final email = isOwn ? ref.watch(editableProfileControllerProvider).value?.email : null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // White status-bar icons over the cobalt hero.
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (n) => _onScroll(n, top),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    key: _topKey,
                    children: [
                      ProfileHeader(
                        key: _heroKey,
                        profile: profile,
                        isOwn: isOwn,
                        onEdit: isOwn
                            ? () => showDialog<void>(
                                context: context,
                                builder: (_) => EditProfileDialog(profile: profile),
                              )
                            : null,
                        onShare: isOwn
                            ? () => showDialog<void>(
                                context: context,
                                builder: (_) => ShareProfileDialog(profile: profile),
                              )
                            : null,
                      ),
                      // The sheet overlaps the hero: its rounded top is drawn up into
                      // the hero's bottom padding, so nothing leaves a gap below.
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -ProfileHeader.sheetOverlap,
                            left: 0,
                            right: 0,
                            height: ProfileHeader.sheetOverlap + 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.mu.colors.night,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(MuRadii.panel)),
                              ),
                            ),
                          ),
                          ProfileSheet(
                            profile: profile,
                            isOwn: isOwn,
                            onKarma: () => setState(() => _section = _Section.karma),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SectionBar(top: _barPad, selected: _section, onChanged: (s) => setState(() => _section = s)),
                ),
                SliverToBoxAdapter(
                  child: switch (_section) {
                    _Section.karma => ProfileKarmaTab(profile: profile, publicMuid: isOwn ? null : profile.muid),
                    _Section.achievements => AchievementsTab(
                      muid: profile.muid,
                      userName: profile.fullName,
                      userEmail: (email?.isEmpty ?? true) ? null : email,
                      isOwnProfile: isOwn,
                      scrollable: false,
                    ),
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: top,
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _underStatusBar ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                child: ColoredBox(color: context.mu.colors.night),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The Karma | Achievements switch. [top] is the band above it: section
/// spacing at rest, the status-bar height once pinned, so it paints over
/// the status bar instead of letting the sheet show through.
class _SectionBar extends SliverPersistentHeaderDelegate {
  _SectionBar({required this.top, required this.selected, required this.onChanged});

  final double top;
  final _Section selected;
  final ValueChanged<_Section> onChanged;

  static const double _bar = 64;

  @override
  double get minExtent => _bar + top;

  @override
  double get maxExtent => _bar + top;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: context.mu.colors.chalk,
      child: Padding(
        padding: EdgeInsets.fromLTRB(MuSpacing.space5, top + MuSpacing.space2, MuSpacing.space5, MuSpacing.space2),
        child: MuSegmented<_Section>(
          values: _Section.values,
          selected: selected,
          label: (s) => s == _Section.karma ? 'Karma' : 'Achievements',
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SectionBar old) => old.top != top || old.selected != selected;
}
