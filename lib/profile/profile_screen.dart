part of petisland.profile;

class ProfileScreen extends StatelessWidget {
  final AuthenticationBloc bloc;

  const ProfileScreen({
    @required this.bloc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 5);
    final Account account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: <Widget>[
          const SizedBox(height: 25),
          AvatarWidget(url: account.user?.avatar?.url),
          _buildName(context, account),
          _buildDarkMode(),
          Divider(),
          ProfileDetailWidget(),
          spacer,
          Divider(),
          BasicFunctionWidget(onTapLogout: _onTapLogout),
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
        title: 'Chế độ ban đêm',
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
    bloc.logout();
  }
}
