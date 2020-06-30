part of petisland_core.service;

abstract class RescueVotingService {
  Future<List<HeroVotingInfo>> getHeroVotings();
  Future<HeroVotingInfo> vote(String rescueId, String heroId);
}

class RescueVotingServiceImpl extends RescueVotingService {
  @protected
  final RescueVotingRepository repository;

  RescueVotingServiceImpl(this.repository);

  @override
  Future<List<HeroVotingInfo>> getHeroVotings() {
    return repository.getHeroVotings();
  }

  @override
  Future<HeroVotingInfo> vote(String rescueId, String heroId) {
    return repository.vote(rescueId, heroId);
  }
}
