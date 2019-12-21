part of pestisland.post.post_edit.bloc;

class PostEditBloc extends TBloc<PostEditEvent, PostEditState> {
  final List<PostImage> postImages = <PostImage>[];
  final List<PostImage> imagesRemoved = <PostImage>[];

  List<String> get images => postImages.map((item) => item.image.url).toList();

  String title = '';
  double price = -1;
  String description = '';
  String location = '';
  PetCategory petCategory;
  List<Tag> tags = <Tag>[];

  PostEditBloc();

  PostEditBloc.fromPost(Post post) {
    this
      ..title = post.title
      ..description = post.description
      ..price = post.price ?? 0
      ..location = post.location
      ..postImages.addAll(post.postImages)
      ..petCategory = post.pet.type;
  }

  @override
  Duration get delayEvent => const Duration(milliseconds: 0);

  @override
  Stream<PostEditState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<PostEditState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case TitleInputChange:
        yield* _handleTitleInputChange(event);
        break;
      case PriceInputChange:
        yield* _handlePriceInputChange(event);
        break;
      case ExpandChange:
        yield* _handleExpandChange(event);
        break;
      case AddImageEvent:
        yield* _handleAddImageEvent(event);
        break;
      case RemoveImageEvent:
        yield* _handleRemoveImageEvent(event);
        break;
      default:
    }
  }

  @override
  PostEditState get initialState => InitState();

  Stream<PostEditState> _handleTitleInputChange(TitleInputChange event) async* {
    this.title = event.title ?? '';
    yield TitleState(event.title);
  }

  Stream<PostEditState> _handlePriceInputChange(PriceInputChange event) async* {
    this.price = event.price ?? 0;
    yield PriceState(event.price);
  }

  Stream<PostEditState> _handleExpandChange(ExpandChange event) async* {
    yield ExpandState();
  }

  Stream<PostEditState> _handleAddImageEvent(AddImageEvent event) async* {
    final PostImage image = PostImage(image: PetImage(url: event.imageLocalPath));
    postImages.add(image);
    yield ImageState(postImages);
  }

  Stream<PostEditState> _handleRemoveImageEvent(RemoveImageEvent event) async* {
    PostImage image = postImages.removeAt(event.index);
    if (image.id != null) imagesRemoved.add(image);
    yield ImageState(postImages);
  }

  void inputChange(String title) {
    add(TitleInputChange(title));
  }

  void priceChange(double price) {
    add(PriceInputChange(price));
  }

  void expandChange() {
    add(ExpandChange());
  }

  void addImage(String imagesPath) {
    add(AddImageEvent(imagesPath ?? ''));
  }

  void removeImage(int index, ImageType type) {
    add(RemoveImageEvent(index, type));
  }
}
