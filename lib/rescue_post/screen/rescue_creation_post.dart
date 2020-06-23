part of petisland.rescue_post.sceen;

class RescueCreationPost extends TStatelessWidget {
  final editingBloc = RescueEditingBloc.create();
  @override
  Widget build(BuildContext context) {
    final title = 'Create Rescue Post';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 1,
        centerTitle: true,
        actions: <Widget>[
          Builder(
            builder: (context) => SendWidget(
              onPressSend: () => _onCreateRescuePost(context),
            ),
          )
        ],
      ),
      body: RescueCreationDetailWidget(editingBloc),
    );
  }

  void _onCreateRescuePost(BuildContext context) {
  
    if (!editingBloc.rescue.titleIsValid) {
      showErrorSnackBar(context: context, content: 'Title is require');
      return;
    }
    if (!editingBloc.rescue.locatonIsValid) {
      showErrorSnackBar(context: context, content: 'Location is require');
      return;
    }
  }
}
