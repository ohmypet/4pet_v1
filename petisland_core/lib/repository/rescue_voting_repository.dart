part of petisland_core.repository;

abstract class RescueVotingRepository {
  Future<List<HeroVotingInfo>> getHeroVotings();
  Future<HeroVotingInfo> vote(String rescueId, String heroId);
}

class MockRescueVotingRepository extends RescueVotingRepository {
  @override
  Future<List<HeroVotingInfo>> getHeroVotings() async {
    return List.generate(MockRescueRepository.ran.nextInt(20), (index) => heroVotingInfo);
  }

  @override
  Future<HeroVotingInfo> vote(String rescueId, String heroId) async {
    return heroVotingInfo;
  }

  HeroVotingInfo get heroVotingInfo {
    return HeroVotingInfo(
      id: ThinId.randomId(),
      hero: MockRescueRepository.account,
      createAt: DateTime.now(),
      isVoted: MockRescueRepository.ran.nextBool(),
      vote: MockRescueRepository.ran.nextInt(1000),
      updateAt: DateTime.now(),
    );
  }
}

class RescueVotingRepositoryImpl extends RescueVotingRepository {
  @protected
  final HttpClient client;

  RescueVotingRepositoryImpl(this.client);
  @override
  Future<List<HeroVotingInfo>> getHeroVotings() {
    // TODO: implement getHeroVotings
    throw UnimplementedError();
  }

  @override
  Future<HeroVotingInfo> vote(String rescueId, String heroId) {
    // TODO: implement vote
    throw UnimplementedError();
  }
}
