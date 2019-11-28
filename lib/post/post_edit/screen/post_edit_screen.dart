part of petisland.post.post_edit.screen;

/// Post edit will be create mode when Post is null
class PostEditScreen extends StatelessWidget {
  ///Will be change String to Post
  final String post;

  PostEditScreen.create() : post = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Đăng Tin"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          PostEditBody(),
        ],
      ),
      bottomNavigationBar: SendWidget(
        onPressSend: _onPressSend,
      ),
    );
  }

  void _onPressSend() {}
}
