import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Landing page footer with logo, links, and social media.
class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0A0C12) : const Color(0xFF1A1D2E),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildBrand()),
                        Expanded(child: _buildLinks('Uygulama', [
                          'Özellikler',
                          'Fiyatlandırma',
                          'SSS',
                        ])),
                        Expanded(child: _buildLinks('Yasal', [
                          'Gizlilik Politikası',
                          'Kullanım Koşulları',
                          'KVKK',
                        ])),
                        Expanded(child: _buildLinks('İletişim', [
                          'Destek',
                          'info@skincheck.ai',
                        ])),
                      ],
                    )
                  : Column(
                      children: [
                        _buildBrand(),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildLinks('Uygulama', [
                              'Özellikler',
                              'Fiyatlandırma',
                              'SSS',
                            ])),
                            Expanded(child: _buildLinks('Yasal', [
                              'Gizlilik Politikası',
                              'Kullanım Koşulları',
                              'KVKK',
                            ])),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(height: 32),
              Divider(
                color: Colors.white.withValues(alpha: 0.1),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 12,
                children: [
                  Text(
                    '© 2026 SkinCheck AI. Tüm hakları saklıdır.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SocialIcon(icon: LucideIcons.instagram),
                      const SizedBox(width: 16),
                      _SocialIcon(icon: LucideIcons.twitter),
                      const SizedBox(width: 16),
                      _SocialIcon(icon: LucideIcons.youtube),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                LucideIcons.scanFace,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'SkinCheck AI',
              style: AppTextStyles.headlineMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Yapay zekâ destekli cilt analizi\nve kişisel bakım asistanın.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 12),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              link,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 18,
        color: Colors.white.withValues(alpha: 0.7),
      ),
    );
  }
}
