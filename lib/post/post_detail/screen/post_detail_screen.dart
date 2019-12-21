part of petisland.post.post_detail.screen;

class PostDetailScreen extends StatelessWidget {
  static const name = '/PostDetailScreen';
  final Post item;

  const PostDetailScreen({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final imageSliderWidget = item.postImages?.isNotEmpty == true
        ? ImageSliderWidget(
            postImages: item.postImages,
            description: 'Ảnh thú cưng',
          )
        : SizedBox();
    return Scaffold(
      appBar: PreferredSize(
        child: PostDetailAppBar(
          hasPermision: hasPermissionEditAndDel(item.account),
          onTapBack: () => _onTapBack(context),
          onTapSeeMore: (_) => _onTapSeeMore(context, _),
        ),
        preferredSize: Size.fromHeight(32),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Flex(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.vertical,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: PostPreviewWidget(item: item),
                      ),
                      Expanded(
                        flex: 1,
                        child: PostButtonBar(item: item),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                buildTextDescription(context, 'Miêu tả'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: PostDescriptionWidget(description: item.description),
                ),
                Container(child: imageSliderWidget, height: 150),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool hasPermissionEditAndDel(Account accountFromPost) {
    final AuthenticationBloc currentAccount = DI.get(AuthenticationBloc);
    final Account account = currentAccount.account;
    if (accountFromPost?.id == account.id) {
      return true;
    } else if (account.role == 'Admin')
      return true;
    else
      return false;
  }

  void _onTapBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTapSeeMore(BuildContext context, SeeMoreType seeMoreType) {
    switch (seeMoreType) {
      case SeeMoreType.Report:
        showModalBottomSheet(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          context: context,
          builder: (_) => KikiReportWidget(
            onSendReport: _senReport,
          ),
        );
        break;
      default:
    }
  }

  void _senReport(ReportData reportData) {
    final TWorker worker = DI.get(TWorker);
    final AuthenticationBloc bloc = DI.get(AuthenticationBloc);

    worker.report(item.id, reportData.text, bloc.account.id);
  }
}
