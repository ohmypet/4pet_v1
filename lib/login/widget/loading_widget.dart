part of petisland.login.widget;

class LoadingWidget extends TStatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      color: TColors.black.withOpacity(0.1),
      child: Center(
        child: Theme(
          data: theme.copyWith(accentColor: theme.primaryColor),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
