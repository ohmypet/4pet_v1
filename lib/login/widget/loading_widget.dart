part of petisland.login.widget;

class LoadingWidget extends TStatelessWidget {
  final String path = TAssets.flare_loading;

  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      color: TColors.text_white.withOpacity(0.15),
      child: Center(
        child: FittedBox(
          child: Theme(
            data: theme.copyWith(accentColor: theme.primaryColor),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
