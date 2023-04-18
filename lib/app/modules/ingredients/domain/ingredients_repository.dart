import 'package:dartz/dartz.dart';
import 'package:recipe_app/app/shared/models/ingredients_model.dart';
import 'package:recipe_app/core/error/failure.dart';

abstract class IngredientsRepository {
  Future<Either<Failure, List<IngredientsModel>>> getIngredients();
}
