import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/petisland.dart';

abstract class TStatefulWidget extends StatefulWidget {
  const TStatefulWidget({Key key}) : super(key: key);

  @override
  TState<TStatefulWidget> createState();
}

abstract class TState<T extends StatefulWidget> extends State<T> {
  void showSnackBar(
    BuildContext context,
    String content,
    Color backgroundColor,
  ) {
    try {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ));
    } catch (ex) {
      Log.error(ex);
    }
  }

  void showErrorSnackBar(String content, {BuildContext context}) {
    showSnackBar(context ?? this.context, content, Colors.red);
  }

  void closeScreen(String screenName, {BuildContext context}) {
    BuildContext buildContext = context ?? this.context;
    closeUntil(screenName, context: buildContext);
    if (Navigator.canPop(buildContext)) Navigator.pop(buildContext);
  }

  void closeUntil(String screenName, {BuildContext context}) {
    BuildContext buildContext = context ?? this.context;
    Navigator.of(buildContext).popUntil(ModalRoute.withName(screenName));
  }

  Future<V> navigateToScreen<V>({@required Widget screen, String screenName}) {
    return Navigator.of(context).push<V>(
      MaterialPageRoute<V>(
        builder: (_) => screen,
        settings: screenName != null ? RouteSettings(name: screenName) : null,
      ),
    );
  }
}
