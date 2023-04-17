import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:tech_task/app/shared/api_client.dart';

final ingredientsRepositoryProvider = Provider(
  (ref) => IngredientsRepositoryImpl(
    ref.read(apiClientProvider),
  ),
);

class IngredientsRepositoryImpl implements IngredientsRepository {
  final ApiClient client;

  IngredientsRepositoryImpl(this.client);

  @override
  Future<List> getIngredients() async {
    throw UnimplementedError();
  }

  @override
  Future getRecipe(List ingredients) async {
    throw UnimplementedError();
  }
}
