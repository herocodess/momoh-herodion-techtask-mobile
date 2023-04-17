import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/providers/ingredients_provider.dart';

import 'get_ingredients_provider_test.mock.dart';

void main() {
  IngredientsProvider ingredientsProvider;

  setUp(() {
    ingredientsProvider = MockIngredientsProvider();
  });

  test('Test for when fetch ingredients is in loading state', () async {
    AsyncValue state;
    when(() => ingredientsProvider.getIngredients()).thenAnswer(
      (_) async {
        state = const AsyncValue.loading();
        return state;
      },
    );

    await ingredientsProvider.getIngredients();
    expect(
      state,
      const AsyncValue.loading(),
    );
    verify(() => ingredientsProvider.getIngredients()).called(1);
  });

  test('Test for when fetch ingredients is in data state', () async {
    AsyncValue state;
    when(() => ingredientsProvider.getIngredients()).thenAnswer(
      (_) async {
        state = const AsyncValue<List>.data([]);
        return state;
      },
    );
    await ingredientsProvider.getIngredients();
    expect(
      state,
      const AsyncValue.data([]),
    );
    verify(() => ingredientsProvider.getIngredients()).called(1);
  });

  test('Test for when fetch ingredients is in error state', () async {
    AsyncValue state;
    StackTrace error;
    when(() => ingredientsProvider.getIngredients()).thenAnswer(
      (_) async {
        error = StackTrace.current;
        state = AsyncValue.error('Error', error);
        return state;
      },
    );
    await ingredientsProvider.getIngredients();
    expect(
      state,
      AsyncValue.error('Error', error),
    );
    verify(() => ingredientsProvider.getIngredients()).called(1);
  });
}
