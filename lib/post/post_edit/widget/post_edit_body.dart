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
              price: postEditBloc.price ?? 0,
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
                    LocationPostInput(postEditBloc),
                    ImagePostInput(postEditBloc),
                    PetCategoryInput(postEditBloc),
                    const SizedBox(height: 150),
                    // Flexible(
                    //   child: state is ExpandState
                    //       ? Flex(
                    //           mainAxisSize: MainAxisSize.min,
                    //           direction: Axis.vertical,
                    //           children: <Widget>[
                    //             LocationPostInput(postEditBloc),
                    //             // PhonePostInput(postEditBloc),
                    //           ],
                    //         )
                    //       : ExpandWidget(postEditBloc),
                    // )
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
