import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_app/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:recipe_app/app/shared/models/ingredients_model.dart';
import 'package:recipe_app/core/error/failure.dart';

import 'ingredients_repository_test.mock.dart';

void main() {
  IngredientsRepository ingredientsRepository;

  setUp(() {
    ingredientsRepository = MockIngredientsRepository();
  });

  test('Fetch all ingredients error state', () async {
    when(() => ingredientsRepository.getIngredients()).thenAnswer(
      (_) async => Left<Failure, List<IngredientsModel>>(
          Failure('Something went wrong')),
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
      (_) async => Right<Failure, List<IngredientsModel>>([]),
    );
    final result = await ingredientsRepository.getIngredients();
    result.fold((l) {}, (r) {
      expect(r, isA<List<IngredientsModel>>());
      expect(r, <IngredientsModel>[]);
    });

    verify(() => ingredientsRepository.getIngredients()).called(1);
  });
}
