import 'package:dartz/dartz.dart';
import 'package:tech_task/app/shared/models/ingredients_model.dart';
import 'package:tech_task/core/error/failure.dart';

abstract class IngredientsRepository {
  Future<Either<Failure, List<IngredientsModel>>> getIngredients();

  Future getRecipe(List ingredients);
}
