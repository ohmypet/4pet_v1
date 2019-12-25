part of petisland.search.widget;

class SearchOptionWidget extends StatelessWidget {
  final String title;
  final bool isActive;

  const SearchOptionWidget({Key key, this.title, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isActive ? _buildActive(context, title) : _buildInActive(context, title);
  }

  Widget _buildActive(BuildContext context, String title) {
    return Container(
      child: Text(title),
    );
  }

  Widget _buildInActive(BuildContext context, String title) {
    return Container(
      child: Text(title),
    );
  }
}
