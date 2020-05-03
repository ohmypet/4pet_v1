part of petisland.register.widget;

class RegisterAccountWidget extends TStatefulWidget {
  RegisterAccountWidget({Key key}) : super(key: key);

  @override
  _RegisterAccountWidgetState createState() => _RegisterAccountWidgetState();
}

class _RegisterAccountWidgetState extends TState<RegisterAccountWidget> {
  static const Duration timeAnimation = Duration(milliseconds: 210);
  static const Curve animation = Curves.ease;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final PageController pageController = PageController();

  final RegisterBloc registerBloc = DI.get(RegisterBloc);

  ThemeData get theme => Theme.of(context);

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    locationController.dispose();
    phoneController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: <Widget>[
        _buildAccountWidget(),
        _buildInfoWidget(),
      ],
    );
  }

  Widget _buildAccountWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Flexible(
                  flex: 9,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      UserInputWidget(
                        usernameController,
                        focusNode: usernameFocusNode,
                        hintText: 'Nhập tài khoản...',
                        icon: Icon(Icons.person, size: 22),
                        onSubmit: _onEmailSubmitted,
                        onChange: _onTextChanged,
                      ),
                      UserInputWidget(
                        passwordController,
                        focusNode: passwordFocusNode,
                        hintText: 'Nhập mật khẩu...',
                        icon: Icon(Icons.vpn_key, size: 22),
                        isObscureText: true,
                        onSubmit: _onPasswordSubmitted,
                        onChange: _onTextChanged,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        pageController.nextPage(
                          duration: timeAnimation,
                          curve: animation,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      onPressed: () {
                        pageController.previousPage(
                          duration: timeAnimation,
                          curve: animation,
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 9,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      UserInputWidget(
                        nameController,
                        hintText: 'Họ và tên',
                        icon: Icon(Icons.perm_identity, size: 22),
                        onChange: _onTextChanged,
                      ),
                      UserInputWidget(
                        locationController,
                        hintText: 'Địa chỉ',
                        icon: Icon(Icons.location_on, size: 22),
                        onChange: _onTextChanged,
                      ),
                      UserInputWidget(
                        phoneController,
                        hintText: 'Số điện thoại',
                        icon: Icon(Icons.phone, size: 22),
                        onChange: _onTextChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Opacity(
                opacity: isValid ? 1 : 0.2,
                child: PetIslandButtonWidget(
                  text: 'Tiếp',
                  onTap: isValid ? _onAccountSubmitted : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEmailSubmitted() {
    usernameFocusNode?.unfocus();
    passwordFocusNode?.requestFocus();
  }

  void _onPasswordSubmitted() {
    passwordFocusNode?.unfocus();
  }

  void _onAccountSubmitted() {
    String getText(TextEditingController controller) =>
        controller?.text?.isEmpty ?? true ? null : controller.text;
    bool haveUser() =>
        nameController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
    User user;
    if (haveUser()) {
      String name = getText(nameController);
      String location = getText(locationController);
      String phone = getText(phoneController);
      user = User(
        name: name,
        address: location,
        phoneNumber: phone,
      );
    }
    registerBloc.submitAccount(usernameController.text, passwordController.text,
        user: user);
  }

  bool get isValid =>
      usernameController.text.isNotEmpty & passwordController.text.isNotEmpty;

  void _onTextChanged(String str) {
    setState(() {});
  }
}
