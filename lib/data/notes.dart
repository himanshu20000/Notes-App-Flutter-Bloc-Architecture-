import 'dart:convert';

class Notes {
  final String title;
  final String desc;
  final String createDate;
  bool isDone;

  Notes(
      {this.title = "",
      this.desc = "",
      this.createDate = "",
      this.isDone = false});

  Notes copyWith({
    String? title,
    String? desc,
    String? createDate,
    bool? isDone,
  }) {
    return Notes(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      createDate: createDate ?? this.createDate,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      createDate: map['createDate'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      title: json['title'],
      desc: json['desc'],
      createDate: json['createDate'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'createDate': createDate,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return '''Todo:{
      title:$title\n,
      desc:$desc\n,
      createDate:$createDate\n,
      isDone:$isDone\n
    }''';
  }
}
