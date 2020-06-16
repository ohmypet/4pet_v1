part of petisland.rescue_post.sceen;

class RescueDetailScreen extends StatelessWidget {
  static const name = '/RescueDetailScreen';
  
  final Rescue rescue;
  final ValueChanged<Rescue> onDeleteRescue;

  const RescueDetailScreen({
    Key key,
    @required this.rescue,
    this.onDeleteRescue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
