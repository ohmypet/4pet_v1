part of petisland.common.widgets;

class TSheets {
  TSheets._();

  static Widget bottomSheet<T>(
    BuildContext context,
    String title,
    Widget child, {
    T result,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    onPressed: () {
                      if (result != null)
                        Navigator.of(context).pop(result);
                      else
                        Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(title, style: TTextStyles.bold(fontSize: 20)),
                ),
                SizedBox(width: 45),
              ],
            ),
          ),
          Divider(height: 1, color: Color.fromRGBO(18, 18, 18, 0.1)),
          Flexible(child: child),
        ],
      ),
    );
  }
}
