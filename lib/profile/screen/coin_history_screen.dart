part of petisland.profile.screen;

class CoinHistoryScreen extends StatefulWidget {
  static const String name = '/CoinHistoryScreen';

  @override
  _CoinHistoryScreenState createState() => _CoinHistoryScreenState();
}

class _CoinHistoryScreenState extends State<CoinHistoryScreen> {
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
      body: CoinHistoryWidget(),
    );
  }
}
