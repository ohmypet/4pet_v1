part of petisland_core.domain;

class PostContainer<T> {
  String type;
  final List<T> data = <T>[];

  static Map<String, dynamic> _mapFn = <String, dynamic>{

  };

  List<PostContainer> 

  PostContainer.fromJson(Map<String, dynamic> json) {
    type = json['type'];

    //Trending
    if (type == PetIslandConstants.categoryTypes[0]) {
      // data = Trea
    }
    // Popularity
    if (type == PetIslandConstants.categoryTypes[1]) {
      // Popularity//
    }

    // Price higth to low
    if (type == PetIslandConstants.categoryTypes[2]) {}

    // Price low to hight

    if (type == PetIslandConstants.categoryTypes[3]) {}

    // Pet category
    if (type == PetIslandConstants.categoryTypes[4]) {}

    // Post
    if (type == PetIslandConstants.categoryTypes[5]) {}
  }
}
