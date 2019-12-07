part of petisland.post.post_edit.widget;

class PostEditBody extends TStatefulWidget {
  @override
  _CreatePostBodyState createState() => _CreatePostBodyState();
}

class _CreatePostBodyState extends TState<PostEditBody> {
  PostEditBloc postEditBloc = DI.get(PostEditBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostEditBloc, PostEditState>(
      bloc: postEditBloc,
      builder: (_, PostEditState state) {
        return Column(
          children: <Widget>[
            SummaryInfoWidget(
              postEditBloc.title ?? "",
              petImage: postEditBloc.imagesLocalPath ?? <String>[],
              price: postEditBloc.price ?? 0,
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
                    ImagePostInput(postEditBloc),
                    PetCategoryInput(postEditBloc),
                    Flexible(
                      child: state is ExpandState
                          ? Flex(
                              mainAxisSize: MainAxisSize.min,
                              direction: Axis.vertical,
                              children: <Widget>[
                                LocationPostInput(postEditBloc),
                                // PhonePostInput(postEditBloc),
                              ],
                            )
                          : ExpandWidget(postEditBloc),
                    )
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
