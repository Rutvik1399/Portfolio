import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../providers/portfolio_providers.dart';

/// Horizontal gradient progress bar fixed to the top edge showing scroll depth.
class CustomScrollProgressBar extends ConsumerWidget {
  const CustomScrollProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(scrollProgressProvider).clamp(0.0, 1.0);

    return SizedBox(
      height: 3.0,
      width: double.infinity,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.odooPurple,
                AppColors.cyanAccent,
                AppColors.cyanAccentLight,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyanAccent,
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
