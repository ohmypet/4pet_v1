part of petisland_core.service;

abstract class ReportService {
  Future<Report> report(String postId, String reason, String accountId,
      {String description});

  Future<List<String>> getReason();
}

class ReportServiceImpl extends ReportService {
  @protected
  final ReportRepository repository;

  ReportServiceImpl(this.repository);
  @override
  Future<Report> report(String postId, String reason, String accountId,
      {String description}) {
    return repository.report(postId, reason, accountId, description: description);
  }

  @override
  Future<List<String>> getReason() {
    return repository.getReason();
  }
}
