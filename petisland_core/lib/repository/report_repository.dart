part of petisland_core.repository;

abstract class ReportRepository {
  Future<Report> report(String postId, String reason, String accountId,
      {String description});

  Future<List<String>> getReason();
}

class ReportRepositoryImpl extends ReportRepository {
  @protected
  final HttpClient client;

  ReportRepositoryImpl(this.client);

  @override
  Future<Report> report(String postId, String reason, String accountId,
      {String description}) {
    final Map<String, dynamic> map = {
      'post': postId,
      'reason': reason,
      'reportedBy': accountId,
      'description': description,
    }..removeWhere((_, item) => item == null);

    return client
        .post<Map<String, dynamic>>('/api/report', map)
        .then((json) => Report.fromJson(json));
  }

  @override
  Future<List<String>> getReason() {
    return client
        .get<List<dynamic>>('/api/report/reason')
        .then((_) => _.cast<String>());
  }
}
