class Periods {
  final int id;
  final String periodGroupId;
  final double weight;
  final String title;
  final bool isClosed;

  Periods(
      {this.id, this.periodGroupId, this.weight, this.title, this.isClosed});

  static Periods fromJson(Map<String, dynamic> json) {
    return Periods(
      id: int.parse(json["id"]),
      periodGroupId: json["grading_period_group_id"],
      weight: json["weight"],
      title: json["title"],
      isClosed: json["is_closed"],
    );
  }
}
