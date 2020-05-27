part of petisland.profile.screen;

class ProfileScreen extends StatefulWidget {
  final AuthenticationBloc bloc;

  const ProfileScreen({
    @required this.bloc,
    Key key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends TState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 5);
    final Account account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    final image = account.user?.avatar?.url;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: <Widget>[
          const SizedBox(height: 25),
          ChooseAvatarWidget(avatar: AvatarWidget(url: image)),
          GestureDetector(
            child: _buildName(context, account),
            onTap: _onTapName,
          ),
          _buildDarkMode(),
          Divider(),
          ProfileDetailWidget(
            onTapMyPost: _onTapMyPost,
            onTapPostLiked: _onTapPostLiked,
            onTapProfile: _onTapProfile,
          ),
          spacer,
          Divider(),
          BasicFunctionWidget(
            onTapLogout: _onTapLogout,
            onTapChangePassword: _onTapChangePassword,
            onTapRating: _onTapRating,
            onTapReport: _onTapReport,
          ),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context, Account account) {
    final String name = account.getName();
    return DefaultTextStyle.merge(
      style: TTextStyles.bold(
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
      child: Text(name),
    );
  }

  Widget _buildDarkMode() {
    return Opacity(
      opacity: 0.2,
      child: SettingOptionWidget(
        title: 'Dark Mode',
        icon: SvgIconWidget(
          icon: SvgPicture.asset(
            TAssets.moon,
            color: TColors.black,
          ),
        ),
        trailing: Switch(
          value: false,
          dragStartBehavior: DragStartBehavior.down,
          onChanged: null,
        ),
      ),
    );
  }

  void _onTapLogout() {
    widget.bloc.logout();
  }

  void _onTapChangePassword() {
    // TODO(tvc12): change password
  }

  void _onTapRating() {
    // TODO(tvc12): navigate to rating
  }

  void _onTapReport() {
    // TODO(tvc12): navigate to report
  }

  void _onTapMyPost() {
    navigateToScreen(
      context: context,
      screen: MyPostScreen(),
      screenName: MyPostScreen.name,
    );
  }

  void _onTapPostLiked() {
    navigateToScreen(
      context: context,
      screen: FavoritePostScreen(),
      screenName: FavoritePostScreen.name,
    );
  }

  void _onTapProfile() {
    _onTapName();
  }

  void _onTapName() {
    navigateToScreen(
      context: context,
      screen: NewProfileScreen(),
    );
  }
}
