class RecipeModel {
  RecipeModel({
    this.title,
    this.ingredients,
  });

  String title;
  List<String> ingredients;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        title: json["title"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
      );
}
