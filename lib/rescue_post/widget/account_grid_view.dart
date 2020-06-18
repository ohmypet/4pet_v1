part of petisland.rescue_post.widget;

class AccountGridView extends StatelessWidget {
  final List<Account> accounts;

  const AccountGridView({
    Key key,
    @required this.accounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: accounts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: _buildUserInfo,
    );
  }

  Widget _buildUserInfo(BuildContext context, int index) {
    return UserInfoWidget(account: accounts[index]);
  }
}
