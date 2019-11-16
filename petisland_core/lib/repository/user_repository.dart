part of petisland_core.repository;

abstract class UserRepository {
  Future<User> createUser(User user);
// User getUser();
}

class UserRepositoryImpl extends UserRepository {
  @protected
  final HttpClient client;

  UserRepositoryImpl(this.client);

  @override
  Future<User> createUser(User user) {
    final Map<String, dynamic> body = user.toJson();
    return client
        .post('/api/user', body)
        .then((Map<String, dynamic> json) => User.fromJson(json));
  }
}
