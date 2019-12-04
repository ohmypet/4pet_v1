part of petisland.post.post_edit.widget;

class PostEditBody extends TStatefulWidget {
  @override
  _CreatePostBodyState createState() => _CreatePostBodyState();
}

class _CreatePostBodyState extends TState<PostEditBody> {
  PostEditBloc postEditBloc = DI.get(PostEditBloc);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
                    TitlePostInput(postEditBloc, titleController),
                    DescPostInput(descriptionController),
                    PricePostInput(postEditBloc, priceController),
                    ImagePostInput(postEditBloc),
                    Flexible(
                      child: state is ExpandState
                          ? Flex(
                              mainAxisSize: MainAxisSize.min,
                              direction: Axis.vertical,
                              children: <Widget>[
                                LocationPostInput(locationController),
                                PhonePostInput(phoneController),
                                ChungLoaiPostInput(phoneController),
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
