import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';

import 'configuration.dart';

void main() async {
  await setupEnvironment();
  final PostService postService = DI.get(PostService);
  final ImageService imageService = DI.get(ImageService);
  final PetCategoryService petCategoryService = DI.get(PetCategoryService);
  final Random random = Random();
  login();

  String idImage;
  Post currentPost;
  List<PetCategory> categories;

  PetCategory pickOne(List<PetCategory> categories) {
    return categories[random.nextInt(categories.length)];
  }

  test('upload image', () async {
    final String path = 'assets/meow.jpeg';
    try {
      final List<PetImage> images =
          await imageService.upload(<String>[path, path]);

      for (PetImage item in images) {
        Log.debug(item.toJson());
        idImage = item.id;
      }
    } catch (ex) {
      Log.error(ex);
    }
  });

  test('Get categories', () async {
    try {
      categories = await petCategoryService.getPetCategories();
      for (PetCategory item in categories) {
        Log.info(item.toJson());
      }
      assert(categories != null);
      assert(categories.isNotEmpty);
      assert(categories.first.id.isNotEmpty);
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });

  test('Create post with empty image string', () async {
    final PostCreateModal postModal = PostCreateModal.create(
      price: 0.0,
      title: 'Ahihi',
      location: 'Dong nai',
      pet: Pet(type: PetCategory(id: pickOne(categories).id)),
    );
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });

  test('Create post with image', () async {
    final PostCreateModal postModal = PostCreateModal.create(
        price: 10,
        title: 'Ahihi',
        location: 'Dong nai',
        pet: Pet(type: PetCategory(id: pickOne(categories).id)),
        description: 'i\'m supper man',
        images: <PetImage>[PetImage(id: idImage)]);
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });

  test('Create post with tags ', () async {
    final PostCreateModal postModal = PostCreateModal.create(
      price: 10,
      title: 'Ahihi',
      location: 'Dong nai',
      pet: Pet(type: PetCategory(id: pickOne(categories).id)),
      description: 'i\'m supper man',
      tags: <Tag>[
        Tag(title: 'dog', description: 'ahihi'),
        Tag(title: 'dog white', description: 'ahihi'),
        Tag(title: 'dog black', description: 'ahihi'),
        Tag(title: 'dog red', description: 'ahihi')
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

  test('Like post', () async {
    try {
      final Post newPost = await postService.like(currentPost.id);
      expect(newPost, isNotNull);
      expect(newPost.getLikes(), greaterThan(0));
    } catch (e) {
      Log.error(e);
      assert(false);
    }
  });

  test('DisLike post', () async {
    try {
      final Post newPost = await postService.like(currentPost.id);
      expect(newPost, isNotNull);
      expect(newPost.getLikes(), equals(0));
    } catch (e) {
      Log.error(e);
      assert(false);
    }
  });

  test('Get post offset = 0, limit = 10', () async {
    final List<Item> posts = await postService.getPosts(0);
    Log.debug('Length: ${posts.length}');
    for (Item post in posts) {
      Log.debug(post.toJson());
    }
    expect(posts, isNotNull);
    expect(posts, isNotEmpty);
    expect(posts.length, greaterThanOrEqualTo(0));
    expect(posts.length, lessThanOrEqualTo(11));
  });

  test('Get post offset = 10, limit = 20', () async {
    final List<Item> posts = await postService.getPosts(10, limit: 20);
    expect(posts, isNotNull);
    expect(posts, isNotEmpty);
    expect(posts.length, greaterThanOrEqualTo(0));
    expect(posts.length, lessThanOrEqualTo(20));

    Log.debug('Length: ${posts.length}');
    for (Item post in posts) {
      Log.debug(post.toJson());
    }
  });
}
