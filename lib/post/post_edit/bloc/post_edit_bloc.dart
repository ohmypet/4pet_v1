part of pestisland.post.post_edit.bloc;

class PostEditBloc extends TBloc<PostEditEvent, PostEditState> {
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
      default:
    }
  }

  @override
  PostEditState get initialState => InitState();

  Stream<PostEditState> _handleTitleInputChange(TitleInputChange event) async* {
    yield TitleState(event.title);
  }

  Stream<PostEditState> _handlePriceInputChange(PriceInputChange event) async* {
    yield PriceState(event.price);
  }

  Stream<PostEditState> _handleExpandChange(ExpandChange event) async* {
    yield ExpandState();
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
}
