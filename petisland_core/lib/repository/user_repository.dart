part of petisland_core.repository;

abstract class UserRepository {
  Future<User> createUser(User user);
  Future<User> updateAvatar(String userId, String newImage, {String deleteImage});
}

class UserRepositoryImpl extends UserRepository {
  @protected
  final HttpClient client;

  UserRepositoryImpl(this.client);

  @override
  Future<User> createUser(User user) {
    final Map<String, dynamic> body = user.toJson();
    return client
        .post<Map<String, dynamic>>('/api/user', body)
        .then((Map<String, dynamic> json) => User.fromJson(json));
  }

  @override
  Future<User> updateAvatar(String userId, String newImage, {String deleteImage}) {
    final body = {
      'avatar': {'newImage': newImage, 'deleteImage': deleteImage}
        ..removeWhere((key, value) => value == null)
    };

    return client
        .put<Map<String, dynamic>>('/api/user/${userId}', body)
        .then((json) => User.fromJson(json));
  }
}
