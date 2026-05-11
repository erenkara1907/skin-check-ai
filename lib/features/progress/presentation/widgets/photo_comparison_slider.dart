import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/photo_comparison_entity.dart';

/// Before/after photo comparison with draggable slider.
class PhotoComparisonSlider extends StatefulWidget {
  const PhotoComparisonSlider({super.key, required this.comparison});

  /// Photo comparison data.
  final PhotoComparisonEntity comparison;

  @override
  State<PhotoComparisonSlider> createState() =>
      _PhotoComparisonSliderState();
}

class _PhotoComparisonSliderState extends State<PhotoComparisonSlider> {
  double _sliderPosition = 0.5;

  @override
  Widget build(BuildContext context) {
    final c = widget.comparison;
    if (c.firstPhotoUrl == null || c.latestPhotoUrl == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormat = DateFormat('dd MMM yyyy', 'tr');

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              context.l10n.comparisonTitle,
              style: AppTextStyles.titleLarge,
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                const height = 300.0;

                return SizedBox(
                  height: height,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (d) {
                      setState(() {
                        _sliderPosition = (d.localPosition.dx / width)
                            .clamp(0.0, 1.0);
                      });
                    },
                    child: Stack(
                      children: [
                        // Latest (right / full background)
                        RepaintBoundary(
                          child: _buildImage(
                            c.latestPhotoUrl!,
                            width,
                            height,
                          ),
                        ),
                        // First (left / clipped)
                        ClipRect(
                          clipper: _LeftClipper(
                            _sliderPosition * width,
                          ),
                          child: RepaintBoundary(
                            child: _buildImage(
                              c.firstPhotoUrl!,
                              width,
                              height,
                            ),
                          ),
                        ),
                        // Divider line
                        Positioned(
                          left: _sliderPosition * width - 1,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        // Drag handle
                        Positioned(
                          left: _sliderPosition * width - 18,
                          top: height / 2 - 18,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(
                              LucideIcons.moveHorizontal,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Date + score labels
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildLabel(
                  context.l10n.beforeLabel,
                  c.firstDate != null
                      ? dateFormat.format(c.firstDate!)
                      : '-',
                  c.firstScore,
                  isDark,
                ),
                const Spacer(),
                _buildLabel(
                  context.l10n.afterLabel,
                  c.latestDate != null
                      ? dateFormat.format(c.latestDate!)
                      : '-',
                  c.latestScore,
                  isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url, double width, double height) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (_, __) => Container(
        color: AppColors.primary.withValues(alpha: 0.1),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => Container(
        color: AppColors.primary.withValues(alpha: 0.1),
        child: const Icon(LucideIcons.imageOff, size: 32),
      ),
    );
  }

  Widget _buildLabel(
    String title,
    String date,
    double score,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.labelSmall.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(date, style: AppTextStyles.bodySmall),
        Text(
          context.l10n.scoreDisplay(score.toStringAsFixed(0)),
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.scoreColor(score),
          ),
        ),
      ],
    );
  }
}

class _LeftClipper extends CustomClipper<Rect> {
  _LeftClipper(this.width);
  final double width;

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, width, size.height);

  @override
  bool shouldReclip(_LeftClipper oldClipper) => oldClipper.width != width;
}
