class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isFavorite;
  String category;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.date,
    this.isFavorite = false,
    required this.category,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
    title: json["title"],
    description: json["description"],
    id: json['id'],
    isFavorite: json['isFavorite'],
    date: json["date"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "id": id,
      "isFavorite": isFavorite,
      "date": date,
      "category": category,
    };
  }
}