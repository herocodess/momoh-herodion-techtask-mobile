import 'package:dartz/dartz.dart';
import 'package:tech_task/app/shared/models/recipe_model.dart';
import 'package:tech_task/core/error/failure.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> getRecipes(List ingredients);
}
