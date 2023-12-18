
class DB_Model {
  late final int? id;
  final String? title;
  final int? tab;

  DB_Model(
      {required this.id,
        required this.title,
      required this.tab});

  DB_Model.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        title = res["title"],
        tab = res["tab"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'tab': tab,

    };
  }
}