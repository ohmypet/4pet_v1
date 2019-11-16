part of petisland.common.state;

abstract class TStatelessWidget extends StatelessWidget {
  Future<T> navigateToScreen<T>({
    @required BuildContext context,
    @required Widget screen,
    String screenName,
  }) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute<T>(
        builder: (_) => screen,
        settings: screenName != null ? RouteSettings(name: screenName) : null,
      ),
    );
  }

  void closeScreen(BuildContext context, String screenName) {
    closeUntil(context, screenName);
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  void closeUntil(BuildContext context, String screenName) {
    Navigator.of(context).popUntil(ModalRoute.withName(screenName));
  }
}
