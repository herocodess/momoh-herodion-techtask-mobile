import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recipe_app/app/modules/recipe/presentation/recipe_page.dart';
import 'package:recipe_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test', (tester) async {
    await dotenv.load();
    await tester.pumpWidget(
      ProviderScope(child: MyApp()),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(Key('splash')), findsOneWidget);

    await Future.delayed(Duration(seconds: 4));

    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('select-time-page')), findsOneWidget);

    final datePickerFinder = find.byKey(Key('date-picker'));
    expect(datePickerFinder, findsOneWidget);
    await tester.tap(datePickerFinder);
    await tester.pump();

    // Find the GestureDetector inside the widget
    final gestureDetectorFinder = find.byKey(Key('gesture'));
    expect(gestureDetectorFinder, findsOneWidget);
    await tester.drag(gestureDetectorFinder, Offset(300, 0));

    await tester.pump(
      Duration(seconds: 3),
    );
    await tester.pumpAndSettle();

    await tester.pump(Duration(seconds: 3));

    expect(find.byKey(Key('ingredients-page')), findsOneWidget);

    final ingredients1 = find.byKey(Key('ingredient-1'));
    final ingredients2 = find.byKey(Key('ingredient-2'));

    expect(ingredients1, findsOneWidget);
    expect(ingredients2, findsOneWidget);

    await tester.tap(ingredients1);
    await tester.pump();
    await tester.tap(ingredients2);
    await tester.pump();

    await tester.pumpAndSettle();

    final mainButtonKeyFinder = find.byKey(Key('main-button'));
    expect(mainButtonKeyFinder, findsWidgets);

    await tester.tap(mainButtonKeyFinder.last);
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.pump(Duration(seconds: 3));

    final recipeListPageFinder = find.byKey(Key('recipe-list-page'));
    expect(recipeListPageFinder, findsOneWidget);

    final recipe1Finder = find.byKey(Key('recipe-1'));
    expect(recipe1Finder, findsOneWidget);

    await tester.tap(recipe1Finder);
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.pump(Duration(seconds: 3));

    await tester.pumpAndSettle();

    final recipePage = find.byType(RecipePage);
    expect(recipePage, findsOneWidget);

    await tester.pump(Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
