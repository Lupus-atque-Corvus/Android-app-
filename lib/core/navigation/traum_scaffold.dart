import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/preferences_provider.dart';
import 'routes.dart';

class _ModuleInfo {
  const _ModuleInfo(this.key, this.icon, this.labelKey, this.route);
  final String key;
  final IconData icon;
  final String labelKey;
  final String route;
}

const _allModules = [
  _ModuleInfo('home', Icons.home_rounded, 'navHome', Routes.home),
  _ModuleInfo('training', Icons.fitness_center_rounded, 'navTraining', Routes.training),
  _ModuleInfo('health', Icons.favorite_rounded, 'navHealth', Routes.health),
  _ModuleInfo('nutrition', Icons.restaurant_rounded, 'navNutrition', Routes.nutrition),
  _ModuleInfo('planning', Icons.calendar_today_rounded, 'navPlanning', Routes.planning),
  _ModuleInfo('supplements', Icons.science_rounded, 'navSupplements', Routes.supplements),
  _ModuleInfo('medication', Icons.medication_rounded, 'navMedication', Routes.medication),
  _ModuleInfo('abstinence', Icons.self_improvement_rounded, 'navAbstinence', Routes.abstinence),
  _ModuleInfo('budget', Icons.account_balance_wallet_rounded, 'navBudget', Routes.budget),
  _ModuleInfo('period', Icons.water_drop_rounded, 'navPeriod', Routes.period),
  _ModuleInfo('settings', Icons.settings_rounded, 'navSettings', Routes.settings),
];

class TraumScaffold extends ConsumerWidget {
  const TraumScaffold({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotKeys = ref.watch(navSlotsProvider);
    final slots = slotKeys
        .map((k) => _allModules.where((m) => m.key == k).firstOrNull)
        .whereType<_ModuleInfo>()
        .toList();

    final activeIndex = slots.indexWhere((m) => location.startsWith(m.route));

    return Scaffold(
      body: child,
      bottomNavigationBar: _TraumBottomNav(
        slots: slots,
        activeIndex: activeIndex < 0 ? 0 : activeIndex,
        onTap: (i) {
          final route = slots[i].route;
          if (!location.startsWith(route)) context.go(route);
        },
      ),
    );
  }
}

class _TraumBottomNav extends StatelessWidget {
  const _TraumBottomNav({
    required this.slots,
    required this.activeIndex,
    required this.onTap,
  });

  final List<_ModuleInfo> slots;
  final int activeIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: onTap,
        items: slots.map((m) {
          return BottomNavigationBarItem(
            icon: Icon(m.icon),
            label: m.key,
          );
        }).toList(),
      ),
    );
  }
}
