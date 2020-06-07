part of petisland.rescue_post.sceen;

class RescueCreationPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Create Rescue Post';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: <Widget>[
          Builder(
            builder: (context) => SendWidget(
              onPressSend: () => _conCreateRescuePost(context),
            ),
          )
        ],
      ),
      body: RescueCreationDetailWidget(RescueEditingBloc.create()),
    );
  }

  void _conCreateRescuePost(BuildContext context) {}
}
