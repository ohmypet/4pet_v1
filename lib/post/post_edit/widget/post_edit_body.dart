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
        return SingleChildScrollView(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: <Widget>[
              SummaryInfoWidget(
                state is TitleState ? state.title : "",
                imageUrl:
                    'https://genknews.genkcdn.vn/2019/7/26/photo-1-15641331912121468899084.jpg',
                price: state is PriceState ? state.price : 0,
              ),
              SizedBox(height: 14),
              TitlePostInput(postEditBloc, titleController),
              DescPostInput(descriptionController),
              PricePostInput(postEditBloc, priceController),
              ImagePostInput(
                postEditBloc,
                image: <String>[
                  'https://genknews.genkcdn.vn/2019/7/26/photo-1-15641331912121468899084.jpg',
                ],
              ),
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
        );
      },
    );
  }
}
