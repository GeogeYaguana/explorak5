class Category {
  final int id;
  final String name;
  final double weight;

  Category({this.id, this.name, this.weight});

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      weight: json["group_weight"],
    );
  }
}
