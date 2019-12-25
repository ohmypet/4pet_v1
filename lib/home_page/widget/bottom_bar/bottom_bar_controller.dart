part of petisland.home_page.widget.bottom_bar;

abstract class BottomBarController {
  void navigateTo(int index);

  void addController(TabController controller);

  void removeController();
}

class BottomBarControllerImpl extends BottomBarController {
  TabController _controller;

  @override
  void navigateTo(int index) {
    if (_controller != null) _controller.animateTo(index, duration: const Duration(milliseconds: 150));
  }

  @override
  void addController(TabController controller) {
    _controller = controller;
  }

  @override
  void removeController() {
    _controller = null;
  }
}
