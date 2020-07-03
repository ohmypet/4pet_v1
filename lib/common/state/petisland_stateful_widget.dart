part of petisland.common.state;

abstract class TStatefulWidget extends StatefulWidget {
  const TStatefulWidget({Key key}) : super(key: key);

  @override
  // ignore: always_specify_types
  TState createState();
}

abstract class TState<T extends StatefulWidget> extends State<T> with BaseTool {}
