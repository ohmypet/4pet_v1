part of petisland.pet_feed.widget;

abstract class PanelRender<T extends Panel> extends TStatelessWidget {
  final T panel;
  static Map<Type, dynamic> renders = <Type, dynamic>{
    Post: renderPost,
    PetCategory: renderPetCategory
  };

  const PanelRender(this.panel, {Key key}) : super(key: key);
}

Widget renderPostDetail(PanelDetail postDetail, {VoidCallback reRender}) {
  final PostItem item = postDetail.postItem;
  final dynamic render = PanelRender.renders[item.runtimeType];
  return render != null ? render(item, reRender: reRender) : SizedBox();
}

Widget renderPost(Post item, {VoidCallback reRender}) {
  return PostWidget(item, reRender: reRender);
}

Widget renderPetCategory(PetCategory item) {
  return PetCategoryWidget(item);
}
