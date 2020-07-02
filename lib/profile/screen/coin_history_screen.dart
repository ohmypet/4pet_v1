part of petisland.profile.screen;

class CoinHistoryScreen extends StatelessWidget {
  static const String name = '/CoinHistoryScreen';
  final CoinHistoryBloc coinHistoryBloc = DI.get(CoinHistoryBloc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coin History',
          style: TTextStyles.bold(
            fontSize: 18,
            color: TColors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: TColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CoinHistoryListingWidget(bloc: coinHistoryBloc),
    );
  }
}
