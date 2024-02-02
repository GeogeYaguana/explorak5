import 'package:flutter_html/flutter_html.dart';

class Pages {
  final int id;
  final String url;
  final double title;
  final bool hide;
  final bool published;
  final bool locked;
  final Html body;

  Pages(
      {this.id,
      this.url,
      this.title,
      this.hide,
      this.published,
      this.locked,
      this.body});

  static Pages fromJson(Map<String, dynamic> json) {
    return Pages(
      id: json["page_id"],
      url: json["url"],
      title: json["title"],
      hide: json["hide_from_students"],
      published: json["hide_fropublishedm_students"],
      locked: json["locked_for_user"],
      body: json["body"],
    );
  }
}
