import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:petisland_core/util/log.dart';

void main() {
  group('Post test', () {
    test('toJson()', () {
      final Post post = Post(
        id: '1234',
        title: 'Buy dog',
        description: 'I wan\'t a big dog',
        location: 'HCM',
        price: 123,
        dueDate: DateTime.now(),
        settings: <String, dynamic>{'Meow': 123},
        status: 'Active',
        likes: 123,
        createBy: null,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        account: Account(
          id: '1234',
          username: 'meomeocf98',
          createAt: DateTime.now(),
          email: 'meomeocf98@gmail.com',
          role: 'Free',
          createBy: null,
          status: 'Active',
          updateAt: DateTime.now(),
          settings: <String, dynamic>{'type': 'admin'},
        ),
        postImages: <PostImage>[
          PostImage(
            image: PetImage(
              id: '123456789',
              createAt: DateTime.now(),
              updateAt: DateTime.now(),
              createBy: null,
              publicId: 'ahihi',
              url: 'https://meomeo.com',
            ),
          ),
          PostImage(
            image: PetImage(
              id: '123456789',
              createAt: DateTime.now(),
              updateAt: DateTime.now(),
              createBy: null,
              publicId: 'ahihi',
              url: 'https://meomeo.com',
            ),
          ),
          PostImage(
            image: PetImage(
              id: '123456789',
              createAt: DateTime.now(),
              updateAt: DateTime.now(),
              createBy: null,
              publicId: 'ahihi',
              url: 'https://meomeo.com',
            ),
          )
        ],
        pet: Pet(
          id: '1234',
          createAt: DateTime.now(),
          updateAt: DateTime.now(),
          createBy: null,
          info: <String, dynamic>{},
          // type: 'dog',
        ),
        postTags: <PostTag>[
          PostTag(
            id: '1234',
            tag: Tag(
              id: '1234',
              title: 'dog',
              description: 'Dog',
              createAt: DateTime.now(),
              updateAt: DateTime.now(),
              createBy: null,
            ),
          )
        ],
      );
      final Map<String, dynamic> map = post.toJson();
      final Post duplicatePost = Post.fromJson(map);
      final String stringJson = json.encode(map);
      expect(stringJson, isNotNull);
      expect(duplicatePost, isNotNull);

      Log.debug(stringJson);
    });
  });

  group('Comment test', () {
    test('toJson()', () {
      final Comment comment = Comment(
        id: '1234',
        message: 'Wtf',
        likes: 1234,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        account: Account(
          id: '1234',
          username: 'meomeocf98',
          createAt: DateTime.now(),
          email: 'meomeocf98@gmail.com',
          role: 'Free',
          createBy: null,
          status: 'Active',
          updateAt: DateTime.now(),
          settings: <String, dynamic>{'type': 'admin'},
        ),
      );

      final String stringJson = json.encode(comment.toJson());
      expect(stringJson, isNotNull);
      Log.debug(stringJson);
    });
  });

  group('User test', () {
    test('toJson', () {
      final User user = User(
        id: '12345',
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        address: <String, dynamic>{'city': 'HCM'},
        bio: 'ahihi',
        createBy: null,
        dob: DateTime.now(),
        name: 'Ahuhu',
        phoneNumber: '0966144938',
        settings: <String, dynamic>{'meow': 'meow meow'},
        avatar: PetImage(
          id: '123456789',
          createAt: DateTime.now(),
          updateAt: DateTime.now(),
          createBy: null,
          publicId: 'ahihi',
          url: 'https://meomeo.com',
        ),
        account: Account(
          id: '1234',
          username: 'meomeocf98',
          createAt: DateTime.now(),
          email: 'meomeocf98@gmail.com',
          role: 'Free',
          createBy: null,
          status: 'Active',
          updateAt: DateTime.now(),
          settings: <String, dynamic>{'type': 'admin'},
        ),
      );
      final String stringJson = json.encode(user.toJson());
      expect(stringJson, isNotNull);
      Log.debug(stringJson);
    });
  });
}
