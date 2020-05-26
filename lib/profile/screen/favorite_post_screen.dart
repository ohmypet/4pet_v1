part of petisland.profile.screen;

class FavoritePostScreen extends StatefulWidget {
  static const String name = '/FavoritePostScreen';

  @override
  _FavoritePostScreenState createState() => _FavoritePostScreenState();
}

class _FavoritePostScreenState extends State<FavoritePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liked Post',
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
      body: FavoritePostComponent(),
    );
  }
}
