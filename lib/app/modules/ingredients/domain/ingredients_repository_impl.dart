import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:tech_task/app/shared/api_client.dart';
import 'package:tech_task/core/error/failure.dart';

final ingredientsRepositoryProvider = Provider(
  (ref) => IngredientsRepositoryImpl(
    ref.read(apiClientProvider),
  ),
);

class IngredientsRepositoryImpl implements IngredientsRepository {
  final ApiClient client;

  IngredientsRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List>> getIngredients() async {
    throw UnimplementedError();
  }

  @override
  Future getRecipe(List ingredients) async {
    throw UnimplementedError();
  }
}
