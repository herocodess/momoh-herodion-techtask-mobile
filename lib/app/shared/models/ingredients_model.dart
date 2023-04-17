class IngredientsModel {
  IngredientsModel({
    this.title,
    this.useBy,
  });

  String title;
  DateTime useBy;

  factory IngredientsModel.fromJson(Map<String, dynamic> json) =>
      IngredientsModel(
        title: json["title"],
        useBy: DateTime.parse(json["use-by"]),
      );
}
