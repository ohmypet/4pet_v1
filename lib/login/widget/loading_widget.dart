part of petisland.login.widget;

class LoadingWidget extends TStatelessWidget {
  final String path = 'assets/flare/loading.flr';
  const LoadingWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      color: TColors.black.withOpacity(0.2),
      child: Center(
        child: SizedBox(
          width: 70,
          child: FlareActor(
            path,
            animation: 'loading',
            sizeFromArtboard: true,
            fit: BoxFit.fitWidth,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
