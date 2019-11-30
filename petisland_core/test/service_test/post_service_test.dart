import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';

import 'configuration.dart';

void main() async {
  await setupEnvironment();
  final PostService postService = DI.get(PostService);
  final ImageService imageService = DI.get(ImageService);

  login();

  String idImage;
  Post currentPost;

  test('upload image', () async {
    final String path = 'assets/meow.jpeg';
    try {
      final List<PetImage> images = await imageService.upload(<String>[path, path]);

      for (PetImage item in images) {
        Log.debug(item.toJson());
        idImage = item.id;
      }
    } catch (ex) {
      Log.error(ex);
    }
  });

  test("Create post with empty image string", () async {
    final PostModal postModal = PostModal.create(
      price: 0.0,
      title: 'Ahihi',
      location: 'Dong nai',
      pet: Pet(type: PetCategory(id: "35d15307-7136-45d5-bfb2-8e63bdc1e108")),
    );
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });

  test("Create post with image", () async {
    final PostModal postModal = PostModal.create(
        price: 10,
        title: 'Ahihi',
        location: 'Dong nai',
        pet: Pet(type: PetCategory(id: "35d15307-7136-45d5-bfb2-8e63bdc1e108")),
        description: "i'm supper man",
        images: <PetImage>[PetImage(id: idImage)]);
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });

  test("Create post with tags ", () async {
    final PostModal postModal = PostModal.create(
      price: 10,
      title: 'Ahihi',
      location: 'Dong nai',
      pet: Pet(type: PetCategory(id: "35d15307-7136-45d5-bfb2-8e63bdc1e108")),
      description: "i'm supper man",
      tags: <Tag>[
        Tag(title: "dog", description: "ahihi"),
        Tag(title: "dog white", description: "ahihi"),
        Tag(title: "dog black", description: "ahihi"),
        Tag(title: "dog red", description: "ahihi")
      ],
      images: <PetImage>[PetImage(id: idImage)],
    );
    try {
      final Post post = await postService.create(postModal);
      currentPost = post;
      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });

  test("Like post", () async {
    try {
      final Post newPost = await postService.like(currentPost.id);
      expect(newPost, isNotNull);
      expect(newPost.likes, greaterThan(0));
    } catch (e) {
      Log.error(e);
      assert(false);
    }
  });
}
