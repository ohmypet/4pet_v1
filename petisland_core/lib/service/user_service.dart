part of petisland_core.service;

abstract class UserService {
  Future<User> createUser(User user);
}

class UserServiceImpl extends UserService {
  @protected
  final UserRepository repository;

  UserServiceImpl(this.repository);

  @override
  Future<User> createUser(User user) {
    return repository.createUser(user);
  }
}
