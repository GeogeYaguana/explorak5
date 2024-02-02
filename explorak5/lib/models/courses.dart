class Course {
  final int id;
  final String name;
  final String startAt;
  final String workflowState;
  final String image;
  final bool isPublic;
  bool showPoint = false;

  Course({
    this.id,
    this.name,
    this.startAt,
    this.workflowState,
    this.image,
    this.isPublic,
  });

  static Course fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      startAt: json['start_at'],
      workflowState: json['workflow_state'],
      image: json['image_download_url'],
      isPublic: json['is_public'],
    );
  }
}
