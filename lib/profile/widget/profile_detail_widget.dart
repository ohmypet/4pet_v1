part of petisland.profile.widget;

class ProfileDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 5);
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        _buildMyInfo(),
        spacer,
        _buildMyPost(),
        spacer,
        _buildLikePost(),
      ],
    );
  }

  Widget _buildMyInfo() {
    return SettingOptionWidget(
      title: 'Thông tin của bạn',
      icon: Icon(Icons.person, color: TColors.scarlet_gum),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: TColors.brown_grey,
      ),
    );
  }

  Widget _buildMyPost() {
    return SettingOptionWidget(
      title: 'Bài viết của bạn',
      icon: SvgIconWidget(
        icon: SvgPicture.asset(
          TAssets.note,
          color: TColors.darkSkyBlue,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: TColors.brown_grey,
      ),
    );
  }

  Widget _buildLikePost() {
    return SettingOptionWidget(
      title: 'Bài viết bạn đã thích',
      icon: Icon(
        Icons.favorite,
        color: TColors.water_melon,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: TColors.brown_grey,
      ),
    );
  }


}
