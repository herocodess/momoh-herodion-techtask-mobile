import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/recipe/domain/recipe_repository.dart';
import 'package:tech_task/app/shared/api_client.dart';
import 'package:tech_task/app/shared/models/recipe_model.dart';
import 'package:tech_task/core/error/failure.dart';

final recipeRepositoryProvider = Provider(
  (ref) => RecipeRepositoryImpl(
    ref.read(apiClientProvider),
  ),
);

class RecipeRepositoryImpl implements RecipeRepository {
  final ApiClient client;

  RecipeRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<RecipeModel>>> getRecipes(
      List ingredients) async {
    try {
      final response = await client.get('recipes?', queryParameters: {
        'ingredients': ingredients.join(','),
      });
      return Right(response.data
          .map<RecipeModel>((e) => RecipeModel.fromJson(e))
          .toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
