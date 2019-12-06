part of petisland.post.post_edit.widget;

class ImageChoosePopup extends TStatefulWidget {
  @override
  _ImageChoosePopupState createState() => _ImageChoosePopupState();
}

class _ImageChoosePopupState extends TState<ImageChoosePopup> {
  @override
  Widget build(BuildContext context) {
    return TSheets.bottomSheet(
      context,
      "Chọn hình ảnh",
      Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("Chọn hình ảnh từ camera"),
            onTap: () => onTapCamera(),
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text("Chọn hình ảnh từ thư viện"),
            onTap: () => onTapGallery(),
          ),
        ],
      ),
    );
  }

  void onTapGallery() async {
    //Key is file name, value is file path
    File imageFile = await FilePicker.getFile(type: FileType.IMAGE);
    Log.info("Image File Path after get by galery:: ${imageFile?.path}");
    Navigator.of(context).pop(imageFile.path);
  }

  void onTapCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile ??= await retrieveLostData();
    Log.info("Image File Path after took:: ${imageFile?.path}");
    Navigator.of(context).pop(imageFile.path);
  }

  Future<File> retrieveLostData() async {
    if (Platform.isAndroid) {
      final LostDataResponse response = await ImagePicker.retrieveLostData();
      return response?.file;
    }
    return null;
  }
}
