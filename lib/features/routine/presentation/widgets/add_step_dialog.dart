import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../domain/entities/routine_step_detail_entity.dart';
import 'product_type_info.dart';

/// Premium modal sheet for adding a new step. Educates the user on what the
/// product does, how to apply it, and the results they can expect.
class AddStepDialog extends StatefulWidget {
  const AddStepDialog({super.key});

  /// Shows the sheet and returns the new step, or null if cancelled.
  static Future<RoutineStepDetailEntity?> show(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showAppBottomSheet<RoutineStepDetailEntity>(
      context: context,
      ref: ref,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      useSafeArea: true,
      builder: (_) => const AddStepDialog(),
    );
  }

  @override
  State<AddStepDialog> createState() => _AddStepDialogState();
}

class _AddStepDialogState extends State<AddStepDialog> {
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedKey = 'cleanser';

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSelect(String key) {
    if (_selectedKey == key) return;
    HapticFeedback.selectionClick();
    setState(() => _selectedKey = key);
  }

  void _submit(ProductTypeInfo info) {
    HapticFeedback.mediumImpact();
    final customName = _nameController.text.trim();
    final notes = _notesController.text.trim();
    final reason = notes.isEmpty ? info.tagline : notes;

    Navigator.of(context).pop(
      RoutineStepDetailEntity(
        step: customName.isEmpty ? info.label : customName,
        productType: info.key,
        reason: reason,
        howToApply: info.howToSteps.join(' • '),
        iconName: info.iconName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final catalog = ProductTypeCatalog.all(context);
    final selected = catalog.firstWhere(
      (p) => p.key == _selectedKey,
      orElse: () => catalog.first,
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.6,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, scrollController) {
        return _SheetContainer(
          isDark: isDark,
          child: Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: _Header(
                      isDark: isDark,
                      onClose: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _ProductTypeRail(
                      items: catalog,
                      selectedKey: _selectedKey,
                      isDark: isDark,
                      onSelect: _onSelect,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _HeroCard(info: selected, isDark: isDark),
                  ),
                  SliverToBoxAdapter(
                    child: _DetailSection(info: selected, isDark: isDark),
                  ),
                  SliverToBoxAdapter(
                    child: _NameInput(
                      controller: _nameController,
                      placeholder: selected.label,
                      isDark: isDark,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _NotesInput(
                      controller: _notesController,
                      isDark: isDark,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: _BottomScrim(isDark: isDark),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _PrimaryCta(
                  info: selected,
                  isDark: isDark,
                  onPressed: () => _submit(selected),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetContainer extends StatelessWidget {
  const _SheetContainer({required this.isDark, required this.child});
  final bool isDark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: child,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.isDark, required this.onClose});
  final bool isDark;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.addStepSheetTitle,
                      style: AppTextStyles.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.l10n.addStepSheetSubtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _CloseButton(onPressed: onClose, isDark: isDark),
            ],
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed, required this.isDark});
  final VoidCallback onPressed;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onPressed,
        radius: 24,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight)
                .withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            LucideIcons.x,
            size: 18,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
      ),
    );
  }
}

class _ProductTypeRail extends StatelessWidget {
  const _ProductTypeRail({
    required this.items,
    required this.selectedKey,
    required this.isDark,
    required this.onSelect,
  });

  final List<ProductTypeInfo> items;
  final String selectedKey;
  final bool isDark;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: SizedBox(
        height: 96,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, i) {
            final item = items[i];
            final isSelected = item.key == selectedKey;
            return _ProductTypeTile(
              info: item,
              isSelected: isSelected,
              isDark: isDark,
              onTap: () => onSelect(item.key),
            );
          },
        ),
      ),
    );
  }
}

class _ProductTypeTile extends StatelessWidget {
  const _ProductTypeTile({
    required this.info,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final ProductTypeInfo info;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final baseBg = isDark ? AppColors.surfaceDark : AppColors.backgroundLight;
    final border = isSelected
        ? info.accent
        : (isDark ? AppColors.borderDark : AppColors.borderLight);
    final labelColor = isSelected
        ? info.accent
        : (isDark
            ? AppColors.textPrimaryDark
            : AppColors.textPrimaryLight);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: 96,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? info.accent.withValues(alpha: isDark ? 0.18 : 0.1)
              : baseBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: border.withValues(alpha: isSelected ? 1.0 : 0.7),
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: info.accent.withValues(alpha: 0.24),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    info.accent,
                    info.accent.withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: info.accent.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(info.icon, size: 20, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              info.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelMedium.copyWith(
                color: labelColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.info, required this.isDark});
  final ProductTypeInfo info;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        ),
        child: Container(
          key: ValueKey(info.key),
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                info.accent.withValues(alpha: 0.92),
                info.accent.withValues(alpha: 0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: info.accent.withValues(alpha: 0.35),
                blurRadius: 26,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: -40,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -20,
                  bottom: -30,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _GlassIconTile(icon: info.icon),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info.label,
                                style: AppTextStyles.headlineMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                info.tagline,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: _HeroPill(
                            icon: LucideIcons.clock,
                            label: context.l10n.bestTimeLabel,
                            value: info.bestTime,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _HeroPill(
                            icon: LucideIcons.timer,
                            label: context.l10n.durationLabel,
                            value: info.duration,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassIconTile extends StatelessWidget {
  const _GlassIconTile({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.info, required this.isDark});
  final ProductTypeInfo info;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Column(
          key: ValueKey('${info.key}_detail'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoBlock(
              icon: LucideIcons.info,
              title: context.l10n.whatIsItLabel,
              isDark: isDark,
              accent: info.accent,
              child: Text(
                info.description,
                style: AppTextStyles.bodyMedium.copyWith(
                  height: 1.5,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            const SizedBox(height: 14),
            _InfoBlock(
              icon: LucideIcons.listOrdered,
              title: context.l10n.howToApplyLabel,
              isDark: isDark,
              accent: info.accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < info.howToSteps.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: i == info.howToSteps.length - 1 ? 0 : 10,
                      ),
                      child: _NumberedStep(
                        index: i + 1,
                        text: info.howToSteps[i],
                        accent: info.accent,
                        isDark: isDark,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _InfoBlock(
              icon: LucideIcons.sparkles,
              title: context.l10n.expectedResultsLabel,
              isDark: isDark,
              accent: info.accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < info.benefits.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: i == info.benefits.length - 1 ? 0 : 8,
                      ),
                      child: _BenefitRow(
                        text: info.benefits[i],
                        accent: info.accent,
                        isDark: isDark,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.icon,
    required this.title,
    required this.isDark,
    required this.accent,
    required this.child,
  });

  final IconData icon;
  final String title;
  final bool isDark;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.backgroundDark.withValues(alpha: 0.5)
            : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: isDark ? 0.2 : 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 15, color: accent),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _NumberedStep extends StatelessWidget {
  const _NumberedStep({
    required this.index,
    required this.text,
    required this.accent,
    required this.isDark,
  });

  final int index;
  final String text;
  final Color accent;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accent,
                accent.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$index',
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                height: 1.4,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.text,
    required this.accent,
    required this.isDark,
  });

  final String text;
  final Color accent;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(
            LucideIcons.check,
            size: 16,
            color: accent,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.4,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),
      ],
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({
    required this.controller,
    required this.placeholder,
    required this.isDark,
  });

  final TextEditingController controller;
  final String placeholder;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.stepNameLabel,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.stepNameOptionalHelper,
            style: AppTextStyles.bodySmall.copyWith(color: textSecondary),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: placeholder,
              prefixIcon: const Icon(LucideIcons.tag, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesInput extends StatelessWidget {
  const _NotesInput({required this.controller, required this.isDark});
  final TextEditingController controller;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.notesOptionalLabel,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: context.l10n.notesOptionalHint,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Icon(LucideIcons.stickyNote, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Subtle scrim fade behind the floating CTA — makes scrolling text readable
/// without introducing a visible footer container.
class _BottomScrim extends StatelessWidget {
  const _BottomScrim({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 110 + bottomInset,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            surface.withValues(alpha: 0),
            surface.withValues(alpha: 0.75),
            surface,
          ],
          stops: const [0, 0.55, 1],
        ),
      ),
    );
  }
}

class _PrimaryCta extends StatelessWidget {
  const _PrimaryCta({
    required this.info,
    required this.isDark,
    required this.onPressed,
  });

  final ProductTypeInfo info;
  final bool isDark;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        14 + MediaQuery.of(context).padding.bottom,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                info.accent,
                info.accent.withValues(alpha: 0.82),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: info.accent.withValues(alpha: 0.45),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.plus, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                context.l10n.addToRoutineButton,
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
