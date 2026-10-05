import 'package:flutter_test/flutter_test.dart';
import 'package:rutvik_portfolio/data/models/portfolio_models.dart';
import 'package:rutvik_portfolio/data/portfolio_data.dart';

void main() {
  group('PortfolioData & Models Unit Tests', () {
    test('Personal information is complete and non-empty', () {
      expect(PortfolioData.fullName, equals('RUTVIK SHAH'));
      expect(PortfolioData.location, contains('Ahmedabad'));
      expect(PortfolioData.tagline, isNotEmpty);
      expect(PortfolioData.rotatingTitles.length, equals(4));
      expect(PortfolioData.email, equals('shahrutvik1399@gmail.com'));
      expect(PortfolioData.phone, contains('7202080956'));
    });

    test('Stats items contain correct benchmark metrics', () {
      expect(PortfolioData.stats.length, equals(5));

      final expStat = PortfolioData.stats.firstWhere(
        (s) => s.label.contains('Experience'),
      );
      expect(expStat.value, equals(5));
      expect(expStat.suffix, equals('+'));

      final dealershipStat = PortfolioData.stats.firstWhere(
        (s) => s.label.contains('Dealership'),
      );
      expect(dealershipStat.value, equals(4.0));

      final usersStat = PortfolioData.stats.firstWhere(
        (s) => s.label.contains('Users'),
      );
      expect(usersStat.value, equals(700.0));
      expect(usersStat.suffix, equals('+'));
    });

    test('Experience item correctly adapts titles and bullets to ViewMode', () {
      final sunray = PortfolioData.experiences.firstWhere(
        (e) => e.company.contains('Sunray'),
      );

      // Developer View
      expect(
        sunray.getTitle(ProfileViewMode.developer),
        equals('Senior Software Engineer, Team Lead'),
      );
      final devBullets = sunray.getBullets(ProfileViewMode.developer);
      expect(devBullets, isNotEmpty);
      expect(
        devBullets.any((b) => b.contains('ICICI') || b.contains('PostgreSQL')),
        isTrue,
      );

      // Functional View
      expect(
        sunray.getTitle(ProfileViewMode.functional),
        equals('Lead Odoo Functional Consultant & Project Lead'),
      );
      final funcBullets = sunray.getBullets(ProfileViewMode.functional);
      expect(funcBullets, isNotEmpty);
      expect(
        funcBullets.any((b) => b.contains('rollout') || b.contains('SOPs')),
        isTrue,
      );
    });

    test('Flagship steps form complete 6-stage lifecycle', () {
      const steps = PortfolioData.flagshipSteps;
      expect(steps.length, equals(6));
      expect(steps[0].title, equals('Vehicle Deal'));
      expect(steps[1].title, equals('Hold Amount'));
      expect(steps[2].title, equals('Booking & Refund'));
      expect(steps[3].title, equals('Gatepass Issuance'));
      expect(steps[4].title, equals('Multi-Branch Accounting'));
      expect(steps[5].title, equals('Bank Reconciliation'));
    });

    test('Key Solutions can be filtered strictly by ProfileViewMode', () {
      final devSolutions = PortfolioData.solutions
          .where((s) => s.category == ProfileViewMode.developer)
          .toList();
      final funcSolutions = PortfolioData.solutions
          .where((s) => s.category == ProfileViewMode.functional)
          .toList();

      expect(devSolutions.length, equals(3));
      expect(funcSolutions.length, equals(3));

      expect(devSolutions.any((s) => s.id == 'busy_tally_wizard'), isTrue);
      expect(
        funcSolutions.any((s) => s.id == 'multi_branch_accounting'),
        isTrue,
      );
    });

    test('Skill groups contain non-empty skills with valid categories', () {
      const groups = PortfolioData.skillGroups;
      expect(groups.length, equals(6));

      for (final group in groups) {
        expect(group.categoryName, isNotEmpty);
        expect(group.skills, isNotEmpty);
      }
    });

    test('Core strengths contain 4 pillars', () {
      expect(PortfolioData.coreStrengths.length, equals(4));
    });
  });
}
