import 'dart:async';
import 'dart:developer';

import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository_impl.dart';

final ingredientsProvider =
    StateNotifierProvider<IngredientsProvider, AsyncValue<List>>(
  (ref) {
    final ingredientsRepository = ref.read(ingredientsRepositoryProvider);
    return IngredientsProvider(ingredientsRepository);
  },
);

class IngredientsProvider extends StateNotifier<AsyncValue<List>> {
  final IngredientsRepository ingredientsRepository;
  IngredientsProvider(this.ingredientsRepository) : super(AsyncValue.loading());

  Future<void> getIngredients() async {
    log('something here');
    state = const AsyncValue.loading();
    final ingredients = await ingredientsRepository.getIngredients();
    ingredients.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
