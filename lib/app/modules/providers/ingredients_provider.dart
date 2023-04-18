import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository_impl.dart';
import 'package:tech_task/app/shared/models/ingredients_model.dart';

final ingredientsProvider = StateNotifierProvider<IngredientsProvider,
    AsyncValue<List<IngredientsModel>>>(
  (ref) {
    final ingredientsRepository = ref.read(ingredientsRepositoryProvider);
    return IngredientsProvider(ingredientsRepository);
  },
);

class IngredientsProvider
    extends StateNotifier<AsyncValue<List<IngredientsModel>>> {
  final IngredientsRepository ingredientsRepository;
  IngredientsProvider(this.ingredientsRepository) : super(AsyncValue.data([]));

  Future<void> getIngredients(
      {ValueChanged<String> onError,
      ValueChanged<List<IngredientsModel>> onSuccess}) async {
    state = const AsyncValue.loading();
    final ingredients = await ingredientsRepository.getIngredients();
    ingredients.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
      log('message: ${l.runtimeType}');
      onError(l.message);
    }, (r) {
      state = AsyncValue.data(r);
      onSuccess(r);
    });
  }
}
