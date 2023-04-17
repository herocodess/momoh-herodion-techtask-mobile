import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';

import 'ingredients_repository_test.mock.dart';

void main() {
  IngredientsRepository ingredientsRepository;

  setUp(() {
    ingredientsRepository = MockIngredientsRepository();
  });

  test('Fetch all ingredients', () async {
    when(() => ingredientsRepository.getIngredients()).thenAnswer(
      (_) async => [],
    );
    expect(
      await ingredientsRepository.getIngredients(),
      [],
    );
    verify(() => ingredientsRepository.getIngredients()).called(1);
  });

  test('Fetch recipe', () async {
    when(() => ingredientsRepository.getRecipe([])).thenAnswer(
      (_) async => [],
    );
    expect(
      await ingredientsRepository.getRecipe([]),
      [],
    );
    verify(() => ingredientsRepository.getRecipe([])).called(1);
  });
}
