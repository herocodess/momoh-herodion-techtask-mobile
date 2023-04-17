import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:tech_task/core/error/failure.dart';

import 'ingredients_repository_test.mock.dart';

void main() {
  IngredientsRepository ingredientsRepository;

  setUp(() {
    ingredientsRepository = MockIngredientsRepository();
  });

  test('Fetch all ingredients error state', () async {
    when(() => ingredientsRepository.getIngredients()).thenAnswer(
      (_) async =>
          Left<Failure, List<dynamic>>(Failure('Something went wrong')),
    );
    final result = await ingredientsRepository.getIngredients();
    result.fold((l) {
      expect(l, isA<Failure>());
      expect(l.message, 'Something went wrong');
    }, (r) {});

    verify(() => ingredientsRepository.getIngredients()).called(1);
  });

  test('Fetch all ingredients success state', () async {
    when(() => ingredientsRepository.getIngredients()).thenAnswer(
      (_) async => Right<Failure, List<dynamic>>([]),
    );
    final result = await ingredientsRepository.getIngredients();
    result.fold((l) {}, (r) {
      expect(r, isA<List<dynamic>>());
      expect(r, <dynamic>[]);
    });

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
