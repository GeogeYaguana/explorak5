class Assignment {
  final int id;
  final String name;
  final String dueAt;
  final bool locked;
  final String unlockAt;
  final int courseId;
  final String description;
  final int attempts;
  final dynamic extensions;
  bool submitted;

  bool showPoint = false;

  Assignment({
    this.id,
    this.name,
    this.dueAt,
    this.locked,
    this.unlockAt,
    this.courseId,
    this.description,
    this.attempts,
    this.extensions,
    this.submitted,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    if (json['allowed_extensions'] == null) {
      json['allowed_extensions'] = ['doc'];
    }
    return Assignment(
      id: json['id'],
      name: json['name'],
      dueAt: json['due_at'],
      locked: json["locked_for_user"],
      unlockAt: json['unlock_at'],
      courseId: json['course_id'],
      description: json['description'], //campo es texto con etiquetas html
      attempts: json['allowed_attempts'],
      extensions: json['allowed_extensions'],
      submitted: json['has_submitted_submissions'],
    );
  }
}
