import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/providers/recipe_provider.dart';

import 'get_recipe_provider_test.mock.dart';

void main() {
  RecipeProvider recipeProvider;

  setUp(() {
    recipeProvider = MockRecipeProvider();
  });

  test('Test for when fetch recipe is in loading state', () async {
    AsyncValue state;
    when(() => recipeProvider.getRecipes(['stuff'])).thenAnswer(
      (_) async {
        state = const AsyncValue.loading();
        return state;
      },
    );

    await recipeProvider.getRecipes(['stuff']);
    expect(
      state,
      const AsyncValue.loading(),
    );
    verify(() => recipeProvider.getRecipes(['stuff'])).called(1);
  });

  test('Test for when fetch recipe is in data state', () async {
    AsyncValue state;
    when(() => recipeProvider.getRecipes(['stuff'])).thenAnswer(
      (_) async {
        state = const AsyncValue<List>.data([]);
        return state;
      },
    );
    await recipeProvider.getRecipes(['stuff']);
    expect(
      state,
      const AsyncValue.data([]),
    );
    verify(() => recipeProvider.getRecipes(['stuff'])).called(1);
  });

  test('Test for when fetch recipe is in error state', () async {
    AsyncValue state;
    StackTrace error;
    when(() => recipeProvider.getRecipes(['stuff'])).thenAnswer(
      (_) async {
        error = StackTrace.current;
        state = AsyncValue.error('Error', error);
        return state;
      },
    );
    await recipeProvider.getRecipes(['stuff']);
    expect(
      state,
      AsyncValue.error('Error', error),
    );
    verify(() => recipeProvider.getRecipes(['stuff'])).called(1);
  });
}
