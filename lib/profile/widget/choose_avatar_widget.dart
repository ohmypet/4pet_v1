part of petisland.profile.widget;

class ChooseAvatarWidget extends StatelessWidget {
  final Widget avatar;
  final VoidCallback onTapCamera;

  const ChooseAvatarWidget({Key key, @required this.avatar, this.onTapCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        child: Stack(
          children: <Widget>[
            avatar,
            Align(
              alignment: Alignment.bottomRight,
              child: _buildIconCamera(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconCamera() {
    return GestureDetector(
      onTap: _onTapCamera,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: TColors.duck_egg_blue,
          shape: BoxShape.circle,
          border: Border.all(
            color: TColors.white,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.camera_alt,
          color: TColors.black,
        ),
      ),
    );
  }

  void _onTapCamera() {
    if (onTapCamera != null) onTapCamera();
  }
}
