import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/domain/domain.dart';

void main() {
  group('Post test', () {
    test('to json', () {
      Post post = Post(
        title: 'Buy dog',
        description: 'I wan\'t a big dog',
        location: 'HCM',
        price: 123,
        dueDate: DateTime.now(),
        settings: <String, dynamic>{'Meow': 123},
        status: 'Active',
        likes: 123,
        
      );
    });
  });
}
