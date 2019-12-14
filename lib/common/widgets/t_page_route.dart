part of petisland.common.widgets;

class TPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  TPageRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(maintainState != null, 'maintainState must not null'),
        super(fullscreenDialog: fullscreenDialog ?? false, settings: settings);

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final Widget result = builder(context);
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Log.info('$runtimeType buildTransitions');
    return ScaleTransition(
      child: child,
      scale: Tween<double>(begin: 0.0, end: 1).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is TPageRoute || previousRoute is TPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return (nextRoute is TPageRoute && !nextRoute.fullscreenDialog);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);
}
