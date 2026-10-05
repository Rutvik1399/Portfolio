import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/not_found_page.dart';
import '../pages/portfolio_page.dart';

/// Application router using GoRouter with path-based URL strategy.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const PortfolioPage();
      },
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) {
    return const NotFoundPage();
  },
);
