import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rutvik_portfolio/data/models/portfolio_models.dart';
import 'package:rutvik_portfolio/presentation/providers/portfolio_providers.dart';
import 'package:rutvik_portfolio/presentation/widgets/view_toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('ViewToggleSwitch renders options and toggles state correctly',
      (WidgetTester tester) async {
    final container = ProviderContainer();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ViewToggleSwitch(),
            ),
          ),
        ),
      ),
    );

    // Verify initial render
    expect(find.text('Developer View'), findsOneWidget);
    expect(find.text('Functional View'), findsOneWidget);

    // Initial state is developer
    expect(
      container.read(viewModeProvider),
      equals(ProfileViewMode.developer),
    );

    // Tap on Functional View
    await tester.tap(find.text('Functional View'));
    await tester.pumpAndSettle();

    // Verify state transitioned to functional
    expect(
      container.read(viewModeProvider),
      equals(ProfileViewMode.functional),
    );

    // Tap back on Developer View
    await tester.tap(find.text('Developer View'));
    await tester.pumpAndSettle();

    // Verify state transitioned back to developer
    expect(
      container.read(viewModeProvider),
      equals(ProfileViewMode.developer),
    );
  });
}
