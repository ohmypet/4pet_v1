part of petisland.home_page.widget.bottom_bar;

typedef BottomItemBuilder = Widget Function(BuildContext context, int index, bool isSelected);

class BottomBarSelector extends StatelessWidget {
  final TabController controller;
  final BottomItemBuilder builder;

  const BottomBarSelector({
    @required this.controller,
    @required this.builder,
    Key key,
  }) : super(key: key);

  @protected
  void nextPage(int delta) {
    final int newIndex = controller.index + delta;
    if (newIndex < 0 || newIndex >= controller.length) return;
    controller.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = CurvedAnimation(
      parent: controller.animation,
      curve: Curves.easeInOut,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (_, Widget child) => Semantics(
        label: 'Page ${controller.index + 1} of ${controller.length}',
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(controller.length, (int tabIndex) {
            return GestureDetector(
              onTap: () => controller.animateTo(tabIndex),
              child: builder(context, tabIndex, controller.index == tabIndex),
            );
          }).toList(),
        ),
      ),
    );
  }
}
