part of petisland.common.widgets;

class THeaderWidget extends SliverPersistentHeaderDelegate {
  THeaderWidget({
    @required this.child,
    @required this.maxExtent,
    @required this.minExtent,
    this.canRebuild,
    this.autoInsertSafeArea = false,
  }) : assert(autoInsertSafeArea != null, 'autoInsertSafeArea must not be null');

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (autoInsertSafeArea == true && shrinkOffset > kToolbarHeight && !overlapsContent) {
      return SafeArea(child: child);
    } else {
      return child;
    }
  }

  @override
  final double maxExtent;

  @override
  final double minExtent;

  final Widget child;

  final bool autoInsertSafeArea;

  final bool Function(SliverPersistentHeaderDelegate) canRebuild;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    if (canRebuild != null)
      return canRebuild(oldDelegate);
    else
      return true;
  }
}
