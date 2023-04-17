import 'package:dartz/dartz.dart';
import 'package:tech_task/core/error/failure.dart';

abstract class IngredientsRepository {
  Future<Either<Failure, List>> getIngredients();

  Future getRecipe(List ingredients);
}
