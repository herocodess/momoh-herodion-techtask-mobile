import 'package:dartz/dartz.dart';
import 'package:recipe_app/app/shared/models/recipe_model.dart';
import 'package:recipe_app/core/error/failure.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> getRecipes(List ingredients);
}
