class Grades {
  final int id;
  final String name;
  double currentScore;
  final double maxScore;
  final int submissionId;
  final int termId;
  final bool isClosed;
  final int groupId;

  Grades({
    this.id,
    this.name,
    this.currentScore,
    this.maxScore,
    this.submissionId,
    this.termId,
    this.isClosed,
    this.groupId,
  });

  static Grades fromJson(Map<String, dynamic> json) {
    if (json["submission"]["score"] == null) {
      json["submission"]["score"] = 0.0;
    }
    return Grades(
      id: json["submission"]["id"],
      name: json["submission"]["assignment"]["name"],
      currentScore: json["submission"]["score"],
      maxScore: json["submission"]["assignment"]["points_possible"],
      submissionId: json["submission"]["id"],
      termId: json["submission"]["grading_period_id"],
      isClosed: json["submission"]["assignment"]["in_closed_grading_period"],
      groupId: json["assignment_group_id"],
    );
  }
}
