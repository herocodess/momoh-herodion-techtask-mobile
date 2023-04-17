import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tech_task/app/modules/ingredients/domain/ingredients_repository.dart';
import 'package:tech_task/app/shared/api_client.dart';
import 'package:tech_task/app/shared/models/ingredients_model.dart';
import 'package:tech_task/core/error/failure.dart';

final ingredientsRepositoryProvider = Provider(
  (ref) => IngredientsRepositoryImpl(
    ref.read(apiClientProvider),
  ),
);

class IngredientsRepositoryImpl implements IngredientsRepository {
  final ApiClient client;

  IngredientsRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<IngredientsModel>>> getIngredients() async {
    try {
      final response = await client.get('ingredients');
      return Right(response.data
          .map<IngredientsModel>((e) => IngredientsModel.fromJson(e))
          .toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
    // return response
    //     .then(
    //       (value) => Right(value
    //           .map<IngredientsModel>((e) => IngredientsModel.fromJson(e))
    //           .toList()),
    //     )
    //     .catchError((e) => Left(ServerFailure()));
  }

  @override
  Future getRecipe(List ingredients) async {
    throw UnimplementedError();
  }
}
