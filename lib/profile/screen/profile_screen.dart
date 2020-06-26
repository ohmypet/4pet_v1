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
  bool isLoading = false;
  final authen = DI.get<AuthenticationBloc>(AuthenticationBloc);
  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 5);
    final Account account = authen.account;
    final image = account.user?.avatar?.url;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            children: <Widget>[
              const SizedBox(height: 25),
              ChooseAvatarWidget(
                avatar: CircleColorWidget(
                  padding: const EdgeInsets.all(5),
                  child: AvatarWidget(
                    url: image,
                    paddingDefaultImage: const EdgeInsets.all(15),
                    fullScreenOnTap: true,
                  ),
                ),
                onTapCamera: _handleOnTapCamera,
              ),
              const SizedBox(height: 5),
              _buildTotalCoin(account),
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
          isLoading ? _buildLoading() : const SizedBox()
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

  void _handleOnTapCamera() {
    chooseImage()
        .whenComplete(() => setState(() => isLoading = true))
        .then((value) => uploadImage(value))
        .then((value) => updateProfile(image: value))
        .then((value) => authen.account.user = value)
        .catchError((ex) => Log.error('ChooseImageError ${ex.toString()}'))
        .whenComplete(() => setState(() => isLoading = false));
  }

  Future<File> chooseImage() {
    return showModalBottomSheet<File>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => ImageChoosePopup(),
    ).then((File file) {
      if (file != null) {
        return Future.value(file);
      } else {
        return retrieveLostData();
      }
    }).then((value) {
      if (value == null) {
        throw Exception('Can\'t get image');
      } else
        return value;
    });
  }

  Future<PetImage> uploadImage(File value) async {
    // TODO(TVC12): Move to bloc in the feature
    final ImageService imageService = DI.get(ImageService);
    final petImages = await imageService.upload([value.absolute.path]);
    if (petImages?.isNotEmpty == true) {
      return petImages.first;
    } else {
      throw PetException('Can\'t upload image');
    }
  }

  Future<User> updateProfile({PetImage image}) {
    // TODO(TVC12): Move to bloc in the feature
    final UserService userService = DI.get(UserService);
    final AuthenticationBloc authenBloc = DI.get(AuthenticationBloc);
    final userId = authenBloc.account.user?.id;
    final oldAvatar = authenBloc.account.user?.avatar?.id;
    if (userId != null) {
      return userService.updateAvatar(userId, image.id, deleteImage: oldAvatar);
    } else {
      throw PetException('Can\t update profile');
    }
  }

  Widget _buildLoading() {
    return Scaffold(
      backgroundColor: TColors.transparent,
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildTotalCoin(Account account) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: formatMoney(account.coin.toDouble()),
            style: TTextStyles.semi(
              color: TColors.water_melon_dark,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: ' coins',
            style: TTextStyles.normal(
              color: TColors.black,
              fontSize: 16
            ).copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
