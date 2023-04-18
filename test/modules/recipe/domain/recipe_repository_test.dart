import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_app/app/modules/recipe/domain/recipe_repository.dart';
import 'package:recipe_app/app/shared/models/recipe_model.dart';
import 'package:recipe_app/core/error/failure.dart';

import 'recipe_repository_test.mock.dart';

void main() {
  RecipeRepository recipeRepository;

  setUp(() {
    recipeRepository = MockRecipeRepository();
  });

  test('Test for when fetch recipe is in error state', () async {
    when(() => recipeRepository.getRecipes(['stuff'])).thenAnswer(
      (_) async =>
          Left<Failure, List<RecipeModel>>(Failure('Something went wrong')),
    );

    final result = await recipeRepository.getRecipes(['stuff']);

    result.fold((l) {
      expect(l, isA<Failure>());
      expect(l.message, 'Something went wrong');
    }, (r) {});
    verify(() => recipeRepository.getRecipes(['stuff'])).called(1);
  });

  test('Test for when fetch recipe is in data state', () async {
    when(() => recipeRepository.getRecipes(['stuff'])).thenAnswer(
      (_) async => Right<Failure, List<RecipeModel>>([]),
    );

    final result = await recipeRepository.getRecipes(['stuff']);

    result.fold((l) {}, (r) {
      expect(r, isA<List<RecipeModel>>());
      expect(r, <RecipeModel>[]);
    });
    verify(() => recipeRepository.getRecipes(['stuff'])).called(1);
  });
}
