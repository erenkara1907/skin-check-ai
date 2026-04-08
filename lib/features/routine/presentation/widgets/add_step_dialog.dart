import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/routine_step_detail_entity.dart';

/// Dialog for adding a new step to a routine.
class AddStepDialog extends StatefulWidget {
  const AddStepDialog({super.key});

  /// Shows the dialog and returns the new step, or null if cancelled.
  static Future<RoutineStepDetailEntity?> show(
    BuildContext context,
  ) async {
    return showDialog<RoutineStepDetailEntity>(
      context: context,
      builder: (_) => const AddStepDialog(),
    );
  }

  @override
  State<AddStepDialog> createState() => _AddStepDialogState();
}

class _AddStepDialogState extends State<AddStepDialog> {
  final _nameController = TextEditingController();
  final _reasonController = TextEditingController();
  String _selectedType = 'cleanser';

  static const _productTypes = {
    'cleanser': ('Temizleyici', LucideIcons.droplets),
    'toner': ('Tonik', LucideIcons.sprayCan),
    'serum': ('Serum', LucideIcons.flaskRound),
    'moisturizer': ('Nemlendirici', LucideIcons.cloud),
    'sunscreen': ('Güneş Kremi', LucideIcons.sun),
    'eye_cream': ('Göz Kremi', LucideIcons.eye),
    'mask': ('Maske', LucideIcons.smile),
    'exfoliant': ('Peeling', LucideIcons.sparkles),
    'oil': ('Yağ', LucideIcons.droplet),
    'retinol': ('Retinol', LucideIcons.moon),
  };

  @override
  void dispose() {
    _nameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor:
          isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Adım Ekle', style: AppTextStyles.titleLarge),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product type selector
            Text('Ürün Tipi', style: AppTextStyles.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _productTypes.entries.map((entry) {
                final isSelected = _selectedType == entry.key;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(entry.value.$2, size: 16),
                      const SizedBox(width: 4),
                      Text(entry.value.$1),
                    ],
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primary.withValues(alpha: 0.2),
                  onSelected: (_) =>
                      setState(() => _selectedType = entry.key),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Step name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Adım Adı',
                hintText: 'Örn: Yüz yıkama',
              ),
            ),
            const SizedBox(height: 12),
            // Reason
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Neden Gerekli?',
                hintText: 'Örn: Gözenekleri temizler',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Ekle'),
        ),
      ],
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final typeLabel = _productTypes[_selectedType]?.$1 ?? _selectedType;
    final iconName = {
      'cleanser': 'droplets',
      'toner': 'spray-can',
      'serum': 'flask-round',
      'moisturizer': 'cloud',
      'sunscreen': 'sun',
      'eye_cream': 'eye',
      'mask': 'smile',
      'exfoliant': 'sparkles',
      'oil': 'droplet',
      'retinol': 'moon',
    }[_selectedType] ?? 'pill';

    Navigator.of(context).pop(
      RoutineStepDetailEntity(
        step: name,
        productType: _selectedType,
        reason: _reasonController.text.trim().isEmpty
            ? '$typeLabel cildiniz için önerilir.'
            : _reasonController.text.trim(),
        iconName: iconName,
      ),
    );
  }
}
