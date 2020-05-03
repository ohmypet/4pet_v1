part of petisland.profile.widget;

class ProfileDetailWidget extends StatelessWidget {
  final VoidCallback onTapProfile;
  final VoidCallback onTapMyPost;
  final VoidCallback onTapPostLiked;

  const ProfileDetailWidget(
      {Key key, this.onTapProfile, this.onTapMyPost, this.onTapPostLiked})
      : super(key: key);

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
      onTap: onTapProfile,
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
      onTap: onTapMyPost,
      icon: SvgIconWidget(
        icon: SvgPicture.asset(
          TAssets.note,
          color: TColors.dark_sky_blue,
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
      onTap: onTapPostLiked,
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
