part of petisland.post.post_edit.widget;

class PostEditBody extends TStatelessWidget {
  final PostEditBloc postEditBloc;

  PostEditBody(this.postEditBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostEditBloc, PostEditState>(
      bloc: postEditBloc,
      builder: (_, PostEditState state) {
        return Column(
          children: <Widget>[
            SummaryInfoWidget(
              postEditBloc.title ?? '',
              petImage: postEditBloc.images ?? <String>[],
              money: postEditBloc.price ?? 0,
              location: postEditBloc.location,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                primary: true,
                child: Flex(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.vertical,
                  children: <Widget>[
                    SizedBox(height: 14),
                    TitlePostInput(postEditBloc),
                    DescPostInput(postEditBloc),
                    PricePostInput(postEditBloc),
                    LocationSelectorWidget(
                      isRequired: true,
                      selectedItem: postEditBloc.location.isNotEmpty ? postEditBloc.location : null,
                      onSelected: (String text) {
                        postEditBloc
                          ..location = text
                          ..priceChange(postEditBloc.price);
                      },
                    ),
                    ImagePostInput(postEditBloc),
                    PetCategoryInput(postEditBloc),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
