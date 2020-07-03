part of petisland.rescue_post.sceen;

class RescueEditorScreen extends TStatefulWidget {
  static const name = '/RescueEditorScreen';
  final Rescue rescue;

  const RescueEditorScreen.create({Key key})
      : this.rescue = null,
        super(key: key);
  const RescueEditorScreen.edit({this.rescue, Key key}) : super(key: key);

  @override
  _RescueCreationScreenState createState() => _RescueCreationScreenState();
}

class _RescueCreationScreenState extends TState<RescueEditorScreen> {
  RescueEditingBloc _bloc;
  bool isLoading = false;
  RescueEditingBloc get editingBloc => _bloc;
  ImageService get imageService => DI.get(ImageService);
  RescueListingBloc get rescueListingBloc => DI.get(RescueListingBloc);
  RescueService get rescueService => DI.get(RescueService);

  @override
  Widget build(BuildContext context) {
    final title = 'Create Rescue Post';
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(title),
            elevation: 1,
            centerTitle: true,
            actions: <Widget>[
              Builder(
                builder: (context) => SendWidget(
                  onPressSend: () => _onTapCompleted(context),
                ),
              )
            ],
          ),
          body: RescueCreationDetailWidget(editingBloc),
        ),
        isLoading ? LoadingWidget() : SizedBox(),
      ],
    );
  }

  void initState() {
    super.initState();
    _bloc = widget.rescue != null
        ? RescueEditingBloc.edit(widget.rescue)
        : RescueEditingBloc.create();
  }

  void _handleCreateRescue(BuildContext context) async {
    final images = await _uploadImage(editingBloc.newImages);
    rescueService
        .create(editingBloc.rescue, images.map((e) => e.id).toList())
        .then((value) => rescueListingBloc.refreshRescuePost())
        .then((value) => this.closeScreen(context, RescueEditorScreen.name))
        .catchError(
          (ex) => {
            setState(() => isLoading = false),
            showErrorSnackBar(
              context: context,
              content: 'Something went wrong, try again later!',
            )
          },
        );
  }

  void _handleEditRescue(BuildContext context) async {
    final newImages = editingBloc.newImages.isEmpty
        ? <PetImage>[]
        : await _uploadImage(editingBloc.newImages);
    final oldImages = editingBloc.oldImages
        .map(
          (url) => editingBloc.rescue.rescueImages
              .firstWhere(
                (element) => element.url == url,
                orElse: () => null,
              )
              ?.id,
        )
        .toList()
          ..removeWhere((element) => element == null);
    rescueService
        .update(
          editingBloc.rescue,
          newImages.map((e) => e.id).toList(),
          oldImages,
        )
        .then((value) => this.closeScreen(context, RescueEditorScreen.name, data: value))
        .then((value) => rescueListingBloc.refreshRescuePost())
        .catchError(
          (ex) => {
            setState(() => isLoading = false),
            showErrorSnackBar(
              context: context,
              content: 'Something went wrong, try again later!',
            )
          },
        );
  }

  void _onTapCompleted(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!editingBloc.rescue.titleIsValid) {
      showErrorSnackBar(context: context, content: 'Title is require');
      return;
    }
    if (!editingBloc.rescue.locatonIsValid) {
      showErrorSnackBar(context: context, content: 'Location is require');
      return;
    }

    setState(() {
      isLoading = true;
    });

    switch (editingBloc.mode) {
      case RescueMode.Create:
        _handleCreateRescue(context);
        break;
      case RescueMode.Edit:
        _handleEditRescue(context);
        break;
      default:
    }
  }

  Future<List<PetImage>> _uploadImage(List<String> paths) {
    return imageService.upload(paths);
  }
}
