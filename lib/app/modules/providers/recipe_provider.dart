import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/app/modules/recipe/domain/recipe_repository.dart';
import 'package:tech_task/app/modules/recipe/domain/recipe_repository_impl.dart';
import 'package:tech_task/app/shared/models/recipe_model.dart';

final recipeProvider =
    StateNotifierProvider<RecipeProvider, AsyncValue<List<RecipeModel>>>((ref) {
  return RecipeProvider(ref.read(recipeRepositoryProvider));
});

class RecipeProvider extends StateNotifier<AsyncValue<List<RecipeModel>>> {
  RecipeProvider(this.recipeRepository) : super(AsyncValue.data([]));
  final RecipeRepository recipeRepository;

  Future<void> getRecipes(List list,
      {ValueChanged<String> onError,
      ValueChanged<List<RecipeModel>> onSuccess}) async {
    state = const AsyncValue.loading();
    final recipes = await recipeRepository.getRecipes(list);
    recipes.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
      onError(l.message);
    }, (r) {
      state = AsyncValue.data(r);
      onSuccess(r);
    });
  }
}
