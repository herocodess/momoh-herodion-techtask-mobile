import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:recipe_app/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:recipe_app/app/shared/api_client.dart';
import 'package:recipe_app/app/shared/models/ingredients_model.dart';
import 'package:recipe_app/core/error/failure.dart';

final ingredientsRepositoryProvider = Provider(
  (ref) => IngredientsRepositoryImpl(
    ref.read(apiClientProvider),
  ),
);

class IngredientsRepositoryImpl implements IngredientsRepository {
  final ApiClient client;

  IngredientsRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<IngredientsModel>>> getIngredients() async {
    try {
      final response = await client.get('ingredients');
      return Right(response.data
          .map<IngredientsModel>((e) => IngredientsModel.fromJson(e))
          .toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
