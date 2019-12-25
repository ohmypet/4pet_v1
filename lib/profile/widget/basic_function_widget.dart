part of petisland.profile.widget;

class BasicFunctionWidget extends StatelessWidget {
  final VoidCallback onTapLogout;

  const BasicFunctionWidget({Key key, this.onTapLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacer = const SizedBox(height: 10);
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        _buildRating(),
        spacer,
        _buildReport(),
        spacer,
        _buildChangePassword(),
        spacer,
        _buildLogout(),
        spacer,
      ],
    );
  }

  Widget _buildChangePassword() {
    return SettingOptionWidget(
      title: 'Đổi mật khẩu',
      icon: Icon(Icons.security),
    );
  }

  Widget _buildRating() {
    return SettingOptionWidget(
      title: 'Đánh giá',
      icon: Icon(Icons.star_half),
    );
  }

  Widget _buildReport() {
    return SettingOptionWidget(
      title: 'Báo cáo và đề xuất',
      icon: Icon(Icons.info_outline),
    );
  }

  Widget _buildLogout() {
    return SettingOptionWidget(
      title: 'Đăng xuất',
      onTap: onTapLogout,
      icon: SvgIconWidget(
        icon: Transform.rotate(
          angle: pi,
          child: SvgPicture.asset(
            TAssets.logout,
            color: TColors.black,
          ),
        ),
      ),
    );
  }
}
