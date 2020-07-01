part of petisland.rescue_post.sceen;

class RescueCreationScreen extends TStatefulWidget {
  static const name = '/RescueCreationScreen';

  @override
  _RescueCreationScreenState createState() => _RescueCreationScreenState();
}

class _RescueCreationScreenState extends TState<RescueCreationScreen> {
  final editingBloc = RescueEditingBloc.create();
  bool isLoading = false;
  ImageService get imageService => DI.get(ImageService);
  RescueService get rescueService => DI.get(RescueService);
  RescueListingBloc get rescueListingBloc => DI.get(RescueListingBloc);

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
                  onPressSend: () => _onCreateRescuePost(context),
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

  void _onCreateRescuePost(BuildContext context) {
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

    if (editingBloc.mode == RescueMode.Create) {
      createRescuePost(context);
    }
  }

  void createRescuePost(BuildContext context) async {
    final images = await _uploadImage(editingBloc.newImages);
    rescueService
        .create(editingBloc.rescue, images.map((e) => e.id).toList())
        .then((value) => rescueListingBloc.refreshRescuePost())
        .then((value) => this.closeScreen(context, RescueCreationScreen.name))
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

  Future<List<PetImage>> _uploadImage(List<String> paths) {
    return imageService.upload(paths);
  }
}
