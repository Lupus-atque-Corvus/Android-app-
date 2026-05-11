import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/preferences_provider.dart';
import '../theme/colors.dart';
import '../../l10n/app_localizations.dart';

// ── Module registry ───────────────────────────────────────────────────────────

class _Mod {
  const _Mod(this.key, this.icon, this.labelKey, this.route);
  final String key;
  final IconData icon;
  final String labelKey;
  final String route;
}

const _modules = [
  _Mod('home', Icons.home_rounded, 'navHome', Routes.home),
  _Mod('training', Icons.fitness_center_rounded, 'navTraining', Routes.training),
  _Mod('health', Icons.favorite_rounded, 'navHealth', Routes.health),
  _Mod('nutrition', Icons.restaurant_rounded, 'navNutrition', Routes.nutrition),
  _Mod('planning', Icons.calendar_today_rounded, 'navPlanning', Routes.planning),
  _Mod('supplements', Icons.science_rounded, 'navSupplements', Routes.supplements),
  _Mod('medication', Icons.medication_rounded, 'navMedication', Routes.medication),
  _Mod('abstinence', Icons.self_improvement_rounded, 'navAbstinence', Routes.abstinence),
  _Mod('budget', Icons.account_balance_wallet_rounded, 'navBudget', Routes.budget),
  _Mod('period', Icons.water_drop_rounded, 'navPeriod', Routes.period),
  _Mod('settings', Icons.settings_rounded, 'navSettings', Routes.settings),
];

bool _isCyan(String key) =>
    key == 'health' || key == 'nutrition' || key == 'supplements' || key == 'abstinence';

Color _accent(String key) => switch (key) {
  'health' || 'nutrition' || 'supplements' || 'abstinence' => TraumColors.cyanBlue,
  'settings' => Colors.white70,
  _ => TraumColors.coralOrange,
};

String _label(AppLocalizations l10n, String key) => switch (key) {
  'navHome' => l10n.navHome,
  'navTraining' => l10n.navTraining,
  'navHealth' => l10n.navHealth,
  'navNutrition' => l10n.navNutrition,
  'navPlanning' => l10n.navPlanning,
  'navSupplements' => l10n.navSupplements,
  'navMedication' => l10n.navMedication,
  'navAbstinence' => l10n.navAbstinence,
  'navBudget' => l10n.navBudget,
  'navPeriod' => l10n.navPeriod,
  'navSettings' => l10n.navSettings,
  _ => key,
};

// ── TraumNavigationBar ────────────────────────────────────────────────────────

class TraumNavigationBar extends ConsumerWidget {
  const TraumNavigationBar({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotKeys = ref.watch(navSlotsProvider);
    final allSlotMods = slotKeys
        .map((k) => _modules.where((m) => m.key == k).firstOrNull)
        .whereType<_Mod>()
        .toList();

    // Show first 4 configured slots in the bar; More button reveals the rest
    final barMods = allSlotMods.take(4).toList();
    final barKeySet = barMods.map((m) => m.key).toSet();
    final moreMods = _modules.where((m) => !barKeySet.contains(m.key)).toList();

    final bottomSafe = MediaQuery.of(context).padding.bottom;
    final l10n = AppLocalizations.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 12 + bottomSafe),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0F1115),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white.withValues(alpha:0.10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.55),
                    blurRadius: 40,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...barMods.map((mod) => _NavItem(
                        mod: mod,
                        isActive: location.startsWith(mod.route),
                        label: _label(l10n, mod.labelKey),
                        onTap: () {
                          HapticFeedback.selectionClick();
                          if (!location.startsWith(mod.route)) context.go(mod.route);
                        },
                      )),
                  _MoreButton(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (ctx) => _MoreSheet(
                          mods: moreMods,
                          location: location,
                          l10n: l10n,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Nav item ──────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.mod,
    required this.isActive,
    required this.label,
    required this.onTap,
  });

  final _Mod mod;
  final bool isActive;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cyan = _isCyan(mod.key);
    final accent = _accent(mod.key);

    // Pill gradient colours from the spec
    final pillGradient = cyan
        ? const LinearGradient(colors: [Color(0x331A5F66), Color(0x1A0D3F46)])
        : const LinearGradient(colors: [Color(0x33FF9A5A), Color(0x1AFFB07A)]);

    final textColor = cyan ? const Color(0xFF7EE7F0) : const Color(0xFFFFB07A);
    // rgba(126,231,240,0.16) and rgba(255,154,90,0.18)
    final glowColor = cyan ? const Color(0x297EE7F0) : const Color(0x2EFF9A5A);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14 : 11,
          vertical: 9,
        ),
        decoration: isActive
            ? BoxDecoration(
                gradient: pillGradient,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: accent.withValues(alpha:0.12)),
                boxShadow: [BoxShadow(color: glowColor, blurRadius: 14)],
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              mod.icon,
              size: 22,
              color: isActive ? textColor : Colors.white.withValues(alpha:0.85),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── More button (always circular) ─────────────────────────────────────────────

class _MoreButton extends StatelessWidget {
  const _MoreButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.04),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha:0.05)),
        ),
        child: Icon(
          Icons.more_horiz_rounded,
          size: 22,
          color: Colors.white.withValues(alpha:0.85),
        ),
      ),
    );
  }
}

// ── More bottom sheet ─────────────────────────────────────────────────────────

class _MoreSheet extends StatelessWidget {
  const _MoreSheet({
    required this.mods,
    required this.location,
    required this.l10n,
  });

  final List<_Mod> mods;
  final String location;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1115),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha:0.10)),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 24 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.15),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.8,
            ),
            itemCount: mods.length,
            itemBuilder: (_, i) {
              final mod = mods[i];
              final isActive = location.startsWith(mod.route);
              final ac = _accent(mod.key);
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  Navigator.pop(context);
                  context.go(mod.route);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isActive
                        ? ac.withValues(alpha:0.12)
                        : Colors.white.withValues(alpha:0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive
                          ? ac.withValues(alpha:0.20)
                          : Colors.white.withValues(alpha:0.08),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        mod.icon,
                        size: 20,
                        color: isActive ? ac : Colors.white.withValues(alpha:0.70),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _label(l10n, mod.labelKey),
                          style: TextStyle(
                            color: isActive ? ac : Colors.white.withValues(alpha:0.70),
                            fontSize: 13,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
