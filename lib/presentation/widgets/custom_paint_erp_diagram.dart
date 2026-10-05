import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/portfolio_models.dart';
import '../../data/portfolio_data.dart';

/// Interactive custom-drawn architecture flow diagram for the Flagship Dealership ERP.
/// Draws glowing connector lines, arrows, step nodes, and highlights active steps.
class CustomPaintErpDiagram extends StatefulWidget {
  final ProfileViewMode viewMode;

  const CustomPaintErpDiagram({
    super.key,
    required this.viewMode,
  });

  @override
  State<CustomPaintErpDiagram> createState() => _CustomPaintErpDiagramState();
}

class _CustomPaintErpDiagramState extends State<CustomPaintErpDiagram>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  int _selectedStep = 0; // 0 to 5

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const steps = PortfolioData.flagshipSteps;
    final activeItem = steps[_selectedStep];

    return Column(
      children: [
        // Flow Diagram Canvas
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 650;
            final canvasHeight = isNarrow ? 280.0 : 130.0;

            return AnimatedBuilder(
              animation: _animController,
              builder: (context, _) {
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, canvasHeight),
                      painter: _ErpFlowPainter(
                        animationProgress: _animController.value,
                        selectedStep: _selectedStep,
                        isDark: isDark,
                        isNarrow: isNarrow,
                        stepCount: steps.length,
                      ),
                    ),
                    // Clickable hit-test overlays for each node
                    _buildInteractiveNodes(
                      constraints.maxWidth,
                      canvasHeight,
                      isNarrow,
                      steps,
                    ),
                  ],
                );
              },
            );
          },
        ),

        const SizedBox(height: 20),

        // Active Step Detail Card
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Container(
            key: ValueKey('${activeItem.step}_${widget.viewMode.name}'),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF161F30)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.viewMode.isDeveloper
                    ? AppColors.cyanAccent.withOpacity(0.4)
                    : AppColors.odooPurple.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.viewMode.isDeveloper
                        ? AppColors.cyanAccent.withOpacity(0.15)
                        : AppColors.odooPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    activeItem.icon,
                    size: 24,
                    color: widget.viewMode.isDeveloper
                        ? AppColors.cyanAccent
                        : AppColors.odooPurpleLight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.odooPurple.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'STAGE 0${activeItem.step}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cyanAccent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              activeItem.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activeItem.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textDarkMuted
                              : AppColors.textLightSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.viewMode.isDeveloper
                            ? activeItem.devNote
                            : activeItem.functionalNote,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: isDark
                              ? AppColors.textDarkPrimary
                              : AppColors.textLightPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveNodes(
    double width,
    double height,
    bool isNarrow,
    List<FlagshipStep> steps,
  ) {
    if (!isNarrow) {
      final stepWidth = width / steps.length;
      return Row(
        children: List.generate(steps.length, (index) {
          return SizedBox(
            width: stepWidth,
            height: height,
            child: InkWell(
              onTap: () => setState(() => _selectedStep = index),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: const SizedBox.expand(),
            ),
          );
        }),
      );
    } else {
      // 2 rows of 3 steps
      return Column(
        children: [
          SizedBox(
            height: height / 2,
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedStep = index),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: const SizedBox.expand(),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: height / 2,
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedStep = index + 3),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: const SizedBox.expand(),
                  ),
                );
              }),
            ),
          ),
        ],
      );
    }
  }
}

/// CustomPainter rendering flow nodes and animated connectors.
class _ErpFlowPainter extends CustomPainter {
  final double animationProgress;
  final int selectedStep;
  final bool isDark;
  final bool isNarrow;
  final int stepCount;

  _ErpFlowPainter({
    required this.animationProgress,
    required this.selectedStep,
    required this.isDark,
    required this.isNarrow,
    required this.stepCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isNarrow) {
      _paintMultiRow(canvas, size);
    } else {
      _paintSingleRow(canvas, size);
    }
  }

  void _paintSingleRow(Canvas canvas, Size size) {
    final yCenter = size.height * 0.42;
    final stepWidth = size.width / stepCount;

    final linePaint = Paint()
      ..color = isDark
          ? const Color(0x33FFFFFF)
          : const Color(0x1F000000)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = AppColors.cyanAccent.withOpacity(0.5)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // Draw background pipeline line
    final firstX = stepWidth * 0.5;
    final lastX = size.width - (stepWidth * 0.5);
    canvas.drawLine(Offset(firstX, yCenter), Offset(lastX, yCenter), linePaint);

    // Draw animated pulse packet along pipeline
    final pulseX = firstX + (lastX - firstX) * animationProgress;
    final pulseGradient = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.cyanAccent,
          AppColors.cyanAccent.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(pulseX, yCenter), radius: 36));
    canvas.drawCircle(Offset(pulseX, yCenter), 36, pulseGradient);

    // Draw steps
    for (int i = 0; i < stepCount; i++) {
      final x = (i * stepWidth) + (stepWidth * 0.5);
      final isSelected = i == selectedStep;

      // Draw node circle
      final circlePaint = Paint()
        ..color = isSelected
            ? AppColors.cyanAccent
            : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0))
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isSelected
            ? AppColors.odooPurpleLight
            : (isDark ? Colors.white24 : Colors.black12)
        ..strokeWidth = isSelected ? 3.0 : 1.5
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(Offset(x, yCenter), isSelected ? 18 : 14, circlePaint);
      canvas.drawCircle(Offset(x, yCenter), isSelected ? 18 : 14, borderPaint);

      // Draw Step Number text inside node
      final textSpan = TextSpan(
        text: '${i + 1}',
        style: TextStyle(
          color: isSelected
              ? Colors.black
              : (isDark ? Colors.white70 : Colors.black87),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(x - (textPainter.width / 2), yCenter - (textPainter.height / 2)),
      );

      // Label below node
      final label = PortfolioData.flagshipSteps[i].title;
      final labelSpan = TextSpan(
        text: label,
        style: TextStyle(
          color: isSelected
              ? (isDark ? AppColors.cyanAccent : AppColors.odooPurple)
              : (isDark ? AppColors.textDarkMuted : AppColors.textLightSecondary),
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      );
      final labelPainter = TextPainter(
        text: labelSpan,
        textDirection: TextDirection.ltr,
        maxLines: 2,
        textAlign: TextAlign.center,
      )..layout(maxWidth: stepWidth - 8);

      labelPainter.paint(
        canvas,
        Offset(x - (labelPainter.width / 2), yCenter + 24),
      );

      // Draw connection arrow between nodes
      if (i < stepCount - 1) {
        final nextX = ((i + 1) * stepWidth) + (stepWidth * 0.5);
        final midX = (x + nextX) / 2;
        _drawArrow(canvas, Offset(midX, yCenter), glowPaint);
      }
    }
  }

  void _paintMultiRow(Canvas canvas, Size size) {
    // Render 2 rows (3 nodes per row) for narrow screens
    final row1Y = size.height * 0.25;
    final row2Y = size.height * 0.75;
    final colWidth = size.width / 3;

    final linePaint = Paint()
      ..color = isDark ? Colors.white24 : Colors.black12
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Row 1: 0 -> 1 -> 2
    canvas.drawLine(
      Offset(colWidth * 0.5, row1Y),
      Offset(size.width - colWidth * 0.5, row1Y),
      linePaint,
    );
    // Row 2: 3 -> 4 -> 5
    canvas.drawLine(
      Offset(colWidth * 0.5, row2Y),
      Offset(size.width - colWidth * 0.5, row2Y),
      linePaint,
    );

    for (int i = 0; i < 6; i++) {
      final row = i < 3 ? 0 : 1;
      final col = i < 3 ? i : (i - 3);
      final x = (col * colWidth) + (colWidth * 0.5);
      final y = row == 0 ? row1Y : row2Y;
      final isSelected = i == selectedStep;

      final circlePaint = Paint()
        ..color = isSelected
            ? AppColors.cyanAccent
            : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), isSelected ? 16 : 12, circlePaint);

      final textSpan = TextSpan(
        text: '${i + 1}',
        style: TextStyle(
          color: isSelected ? Colors.black : (isDark ? Colors.white : Colors.black),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      );
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
        ..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));

      // Label below
      final label = PortfolioData.flagshipSteps[i].title;
      final labelSpan = TextSpan(
        text: label,
        style: TextStyle(
          color: isSelected
              ? (isDark ? AppColors.cyanAccent : AppColors.odooPurple)
              : (isDark ? AppColors.textDarkMuted : AppColors.textLightSecondary),
          fontSize: 10,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      );
      final lp = TextPainter(
        text: labelSpan,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        textAlign: TextAlign.center,
      )..layout(maxWidth: colWidth - 6);
      lp.paint(canvas, Offset(x - lp.width / 2, y + 16));
    }
  }

  void _drawArrow(Canvas canvas, Offset center, Paint paint) {
    final path = Path()
      ..moveTo(center.dx - 4, center.dy - 4)
      ..lineTo(center.dx + 4, center.dy)
      ..lineTo(center.dx - 4, center.dy + 4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ErpFlowPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.selectedStep != selectedStep ||
        oldDelegate.isDark != isDark ||
        oldDelegate.isNarrow != isNarrow;
  }
}
