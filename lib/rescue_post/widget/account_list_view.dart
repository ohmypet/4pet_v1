part of petisland.rescue_post.widget;

class AccountListView extends StatelessWidget {
  final List<Account> accounts;

  const AccountListView({
    Key key,
    @required this.accounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: accounts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildUserInfo,
        separatorBuilder: _buildDivider,
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, int index) {
    return SizedBox(
      width: 125,
      child: UserInfoWidget(account: accounts[index]),
    );
  }

  Widget _buildDivider(BuildContext context, int index) {
    return Container(
      width: 0.5,
      margin: const EdgeInsets.all(5),
      color: TColors.brown_grey,
    );
  }
}
