class ExploredCountry {
  late String countryId;
  late DateTime exploredAt;

  ExploredCountry({
    required this.countryId,
    required this.exploredAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'countryId': countryId,
      'exploredAt': exploredAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ExploredCountry{countryId: $countryId, exploredAt: $exploredAt}';
  }
}