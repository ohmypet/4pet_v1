part of petisland_core.service;

abstract class UserService {
  Future<User> createUser(User user);
  Future<User> updateAvatar(String userId, String newImage, {String deleteImage});
}

class UserServiceImpl extends UserService {
  @protected
  final UserRepository repository;

  UserServiceImpl(this.repository);

  @override
  Future<User> createUser(User user) {
    return repository.createUser(user);
  }

  @override
  Future<User> updateAvatar(String userId, String newImage, {String deleteImage}) {
    return repository.updateAvatar(userId, newImage, deleteImage: deleteImage);
  }
}
