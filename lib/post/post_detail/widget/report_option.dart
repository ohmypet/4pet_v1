part of petisland.post.screen.widget;

class ReportOption extends StatefulWidget {
  final String text;
  final List<bool> optionChoosen;
  final int index;
  final Function setStateParent;

  ReportOption(this.text, this.optionChoosen, this.index, this.setStateParent);

  @override
  _ReportOptionState createState() => _ReportOptionState();
}

class _ReportOptionState extends State<ReportOption> {
  String text;
  List<bool> optionChoosen;
  int index;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    optionChoosen = widget.optionChoosen;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(6);
    return GestureDetector(
      onTap: () => setState(
        () {
          optionChoosen[index] = !optionChoosen[index];
          widget.setStateParent();
        },
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: optionChoosen[index]
              ? TColors.water_melon
              : TColors.duck_egg_blue.withAlpha(200),
          borderRadius: radius,
        ),
        child: Text(
          text,
          style: TTextStyles.semi(
            color:
                optionChoosen[index] ? TColors.text_white : TColors.black.withAlpha(200),
          ),
        ),
      ),
    );
  }
}
