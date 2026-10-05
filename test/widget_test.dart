import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rutvik_portfolio/presentation/sections/stats/stats_section.dart';
import 'package:rutvik_portfolio/presentation/widgets/section_header.dart';

void main() {
  testWidgets('SectionHeader renders title, badge, and subtitle correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeader(
            badge: '01 // TEST BADGE',
            title: 'Test Section Title',
            subtitle: 'This is a test subtitle for SectionHeader component.',
          ),
        ),
      ),
    );

    expect(find.text('01 // TEST BADGE'), findsOneWidget);
    expect(find.text('Test Section Title'), findsOneWidget);
    expect(
      find.text('This is a test subtitle for SectionHeader component.'),
      findsOneWidget,
    );
  });

  testWidgets('StatsSection renders all primary metrics from PortfolioData', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: StatsSection())),
      ),
    );

    // Initial pump
    await tester.pump();

    // Verify stat labels exist
    expect(find.text('Years Experience'), findsOneWidget);
    expect(find.text('Dealership Groups'), findsOneWidget);
    expect(find.text('ERP Users'), findsOneWidget);
    expect(find.text('ICICI Banking API'), findsOneWidget);
    expect(find.text('GST Compliance'), findsOneWidget);

    // Advance animation clock to let animated counters finish
    await tester.pump(const Duration(seconds: 2));

    // Verify counter values
    expect(find.text('5+'), findsOneWidget);
    expect(find.text('700+'), findsOneWidget);
  });
}
