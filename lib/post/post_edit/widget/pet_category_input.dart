part of petisland.post.post_edit.widget;

class PetCategoryInput extends TStatelessWidget {
  final List<PetCategory> categories =
      DI.get<AuthenticationBloc>(AuthenticationBloc).categories;
  final PostEditBloc bloc;

  PetCategoryInput(this.bloc) {
    if (bloc.petCategory == null) {
      bloc.petCategory = categories.isNotEmpty ? categories.first : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 13, right: 5),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 5),
            _TitleWidget(title: 'Chủng loại', isRequired: false),
            TDropDown.builder(
              initSelectedItem: categories.indexWhere(
                  (petCategory) => bloc.petCategory.id == petCategory.id),
              itemCount: categories.length,
              onSelectedChanged: _onSelectedChanged,
              builder: _builDescription,
            )
          ],
        ),
      ),
    );
  }

  void _onSelectedChanged(int index) {
    final PetCategory petCategory = categories[index];
    bloc.petCategory = petCategory;
  }

  Widget _builDescription(BuildContext context, int index) {
    final theme = Theme.of(context);

    final PetCategory petCategory = categories[index];
    return Text(
      petCategory.name,
      style: theme.textTheme.headline6.copyWith(
        fontSize: 16,
        color: theme.accentColor,
      ),
    );
  }
}
