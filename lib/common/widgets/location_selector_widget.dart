part of petisland.common.widgets;

class LocationSelectorWidget extends StatelessWidget {
  final bool isRequired;
  final String hintText;
  final String selectedItem;
  final ValueChanged<String> onSelected;
  final EdgeInsetsGeometry padding;

  const LocationSelectorWidget({
    Key key,
    this.isRequired = true,
    this.hintText = 'Ho Chi Minh City, Vietnam',
    this.selectedItem,
    this.onSelected,
    this.padding = const EdgeInsets.only(left: 15, right: 10),
  }) : super(key: key);
  @override
  Widget build(Object context) {
    return DropdownInputWidget<String>(
      onFind: _handleOnFind,
      title: 'Location',
      isRequired: isRequired,
      hintText: 'Ho Chi Minh City, Vietnam',
      selectedItem: selectedItem,
      onSelected: onSelected,
      padding: padding,
    );
  }

  Future<List<String>> _handleOnFind(String text) {
    final googleService = DI.get<LocationService>(LocationService);
    return googleService.getSuggestionLocation(text).then((resp) {
      if (resp.predictions.isNotEmpty) {
        return resp.predictions.map((location) => location.description).toList();
      } else {
        return [text];
      }
    }).catchError((ex) => [text]);
  }
}
