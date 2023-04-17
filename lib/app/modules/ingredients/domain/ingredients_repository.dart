abstract class IngredientsRepository {
  Future<List> getIngredients();

  Future getRecipe(List ingredients);
}
