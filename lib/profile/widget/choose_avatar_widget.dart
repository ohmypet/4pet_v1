part of petisland.profile.widget;

class ChooseAvatarWidget extends StatelessWidget {
  final Widget avatar;
  final VoidCallback onTapCamera;

  const ChooseAvatarWidget({Key key, @required this.avatar, this.onTapCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: TGradients.avatarGradient2,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 150,
                width: 150,
                child: FittedBox(
                  child: avatar,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          _buildIconCamera()
        ],
      ),
    );
  }

  Widget _buildIconCamera() {
    return Container(
      height: 150,
      width: 150,
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _onTapCamera,
        child: Container(
          decoration: BoxDecoration(
            color: TColors.duck_egg_blue,
            shape: BoxShape.circle,
            border: Border.all(
              color: TColors.white,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.camera_alt),
          ),
        ),
      ),
    );
  }

  void _onTapCamera() {
    if (onTapCamera != null) onTapCamera();
  }
}
