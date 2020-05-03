part of petisland.post.screen.widget;

class ReportData {
  final String text;

  ReportData(this.text);
}

class KikiReportWidget extends StatefulWidget {
  final ValueChanged<ReportData> onSendReport;

  const KikiReportWidget({Key key, this.onSendReport}) : super(key: key);

  @override
  _KikiReportWidgetState createState() => _KikiReportWidgetState();
}

class _KikiReportWidgetState extends TState<KikiReportWidget> {
  bool isActive = false;

  final List<String> feedbackOption =
      DI.get<AuthenticationBloc>(AuthenticationBloc).reportContents;
  List<bool> optionChosen;

  void callbackSetState() {
    isActive = hasFeedback();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    optionChosen = List.generate(feedbackOption.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Widget title = _buildTitle();
    final Widget button = _buildButton(isActive, context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      // padding: const EdgeInsets.symmetric(vertical: 0),
      children: <Widget>[
        title,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Wrap(
            children: List.generate(
              feedbackOption.length,
              (index) {
                return ReportOption(
                  feedbackOption[index],
                  optionChosen,
                  index,
                  callbackSetState,
                );
              },
            ),
          ),
        ),
        Divider(),
        button,
      ],
    );
  }

  Widget _buildTitle() {
    final String title =
        'Chúng tôi sẽ ghi nhận phản hồi của bạn về bài viết này. Đó sẽ là cơ sở giúp chúng tôi tìm hiểu vấn đề bài viết này đang gặp phải.';
    return ListTile(
      leading: Icon(
        Icons.report,
        color: TColors.water_melon,
      ),
      title: Text(
        title,
        style: TTextStyles.bold(fontSize: 16, color: TColors.black),
      ),
      trailing: SizedBox(width: 15),
    );
  }

  Widget _buildButton(bool isActive, BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle style =
        isActive ? theme.accentTextTheme.button : theme.textTheme.button;
    final VoidCallback onTap = isActive ? _onTapButton : null;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: FlatButton(
        child: Text('BÁO CÁO', style: style.copyWith(fontSize: 22)),
        color: theme.primaryColor,
        onPressed: onTap,
        disabledColor: TColors.duck_egg_blue,
      ),
    );
  }

  void _onTapButton() {
    final feedbacks = getFeedbacks();
    final report = makeReport(feedbacks);
    Navigator.pop(context);
    Log.info('_onTapButton:: $report');
    if (widget.onSendReport != null) {
      widget.onSendReport(ReportData(report));
    }
  }

  List<String> getFeedbacks() {
    final List<String> feedbacks = [];
    for (int i = 0; i < optionChosen.length; i++) {
      final bool choose = optionChosen[i];
      final String feedback = feedbackOption[i];
      if (choose) feedbacks.add(feedback);
    }
    return feedbacks;
  }

  String makeReport(List<String> feedbacks) {
    if (feedbacks.isNotEmpty) {
      final StringBuffer buffer = StringBuffer();
      final firstString = feedbacks.removeAt(0);

      final completedBuffer = feedbacks.fold<StringBuffer>(
          buffer, (buffer, feedback) => buffer..write('|$feedback'));

      return firstString + completedBuffer.toString();
    } else
      return '';
  }

  bool hasFeedback() {
    return optionChosen.contains(true);
  }
}
