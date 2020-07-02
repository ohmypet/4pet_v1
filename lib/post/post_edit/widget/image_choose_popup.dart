part of petisland.post.post_edit.widget;

class ImageChoosePopup extends TStatefulWidget {
  @override
  _ImageChoosePopupState createState() => _ImageChoosePopupState();
}

class _ImageChoosePopupState extends TState<ImageChoosePopup> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(
          color: TColors.water_melon
        ),
      ),
      child: TSheets.bottomSheet(
        context,
        'Choose your image',
        Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera_alt, color: TColors.water_melon),
              title: Text('Take a photo'),
              onTap: () => onTapCamera(),
            ),
            ListTile(
              leading: Icon(Icons.image, color: TColors.water_melon),
              title: Text('Choose from library'),
              onTap: () => onTapGallery(),
            ),
          ],
        ),
      ),
    );
  }

  void onTapGallery() async {
    File imageFile = await FilePicker.getFile(type: FileType.image);
    Log.info('Image File Path after get by galery:: ${imageFile?.path}');
    Navigator.of(context).pop<File>(imageFile);
  }

  void onTapCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    Log.info('Image File Path after took:: ${imageFile?.path}');
    Navigator.of(context).pop<File>(imageFile);
  }
}

Future<File> retrieveLostData() async {
  if (Platform.isAndroid) {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    return response?.file;
  }
  return null;
}
