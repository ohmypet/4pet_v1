part of petisland.profile.widget;

class ProfileDetailWidget extends StatelessWidget {
  final VoidCallback onTapProfile;
  final VoidCallback onTapMyPost;
  final VoidCallback onTapPostLiked;
  final VoidCallback onTapCoinHistory;

  const ProfileDetailWidget({
    Key key,
    this.onTapProfile,
    this.onTapMyPost,
    this.onTapPostLiked,
    this.onTapCoinHistory
  }) : super(key: key);

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
        spacer,
        _buildCoinHistory(),
      ],
    );
  }

  Widget _buildMyInfo() {
    return SettingOptionWidget(
      title: 'Your Profile',
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
      title: 'Your Post',
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
      title: 'Liked Post',
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

  Widget _buildCoinHistory() {
    return SettingOptionWidget(
      title: 'Coin History',
      onTap: onTapCoinHistory,
      icon: Icon(
        Icons.history,
        color: TColors.brown_grey,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: TColors.brown_grey,
      ),
    );
  }
}
