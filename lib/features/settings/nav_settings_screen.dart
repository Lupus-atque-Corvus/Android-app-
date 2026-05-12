import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';

// ── Module registry (mirrors traum_navigation_bar.dart) ───────────────────────

class _Mod {
  const _Mod(this.key, this.label, this.icon);
  final String key;
  final String label;
  final IconData icon;
}

const _allMods = [
  _Mod('training', 'Training', Icons.fitness_center_rounded),
  _Mod('health', 'Gesundheit', Icons.favorite_rounded),
  _Mod('nutrition', 'Ernährung', Icons.restaurant_rounded),
  _Mod('planning', 'Planung', Icons.calendar_today_rounded),
  _Mod('supplements', 'Supplemente', Icons.science_rounded),
  _Mod('medication', 'Medikamente', Icons.medication_rounded),
  _Mod('abstinence', 'Abstinenz', Icons.self_improvement_rounded),
  _Mod('budget', 'Budget', Icons.account_balance_wallet_rounded),
  _Mod('period', 'Zyklus', Icons.water_drop_rounded),
  _Mod('settings', 'Einstellungen', Icons.settings_rounded),
];

_Mod? _find(String key) =>
    _allMods.where((m) => m.key == key).firstOrNull;

Color _accent(String key) => switch (key) {
  'health' || 'nutrition' || 'supplements' || 'abstinence' => TraumColors.cyanBlue,
  'settings' => Colors.white70,
  _ => TraumColors.coralOrange,
};

// ── Screen ────────────────────────────────────────────────────────────────────

class NavSettingsScreen extends ConsumerWidget {
  const NavSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slots = ref.watch(navSlotsProvider);
    final notifier = ref.read(navSlotsProvider.notifier);
    final isPeriodEnabled = ref.watch(isPeriodTrackingEnabledProvider);

    final availableMods = _allMods
        .where((m) => m.key != 'period' || isPeriodEnabled)
        .where((m) => !slots.contains(m.key))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation anpassen')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          // ── Live preview ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'VORSCHAU',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: TraumColors.coralOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _NavPreview(slots: slots),

          // ── Active slots ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'AKTIVE SLOTS (max. 4)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: TraumColors.coralOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _ActiveSlotsList(slots: slots, notifier: notifier),

          // ── Available modules ─────────────────────────────────────────────
          if (availableMods.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'VERFÜGBARE MODULE',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: TraumColors.coralOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _ModuleGrid(mods: availableMods, slots: slots, notifier: notifier),
          ],
        ],
      ),
    );
  }
}

// ── Live nav bar preview ───────────────────────────────────────────────────────

class _NavPreview extends StatelessWidget {
  const _NavPreview({required this.slots});
  final List<String> slots;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1115),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 24, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Home — always fixed
          _PreviewItem(
            icon: Icons.home_rounded,
            label: 'Start',
            accent: TraumColors.coralOrange,
            isActive: true,
          ),
          // Configurable slots
          ...slots.map((k) {
            final mod = _find(k);
            if (mod == null) return const SizedBox.shrink();
            return _PreviewItem(
              icon: mod.icon,
              label: mod.label,
              accent: _accent(mod.key),
              isActive: false,
            );
          }),
          // More — always last
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Icon(Icons.more_horiz_rounded, size: 20, color: Colors.white.withValues(alpha: 0.85)),
          ),
        ],
      ),
    );
  }
}

class _PreviewItem extends StatelessWidget {
  const _PreviewItem({required this.icon, required this.label, required this.accent, required this.isActive});
  final IconData icon;
  final String label;
  final Color accent;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: isActive ? 12 : 10, vertical: 8),
      decoration: isActive
          ? BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: accent.withValues(alpha: 0.12)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: isActive ? accent : Colors.white.withValues(alpha: 0.75)),
          if (isActive) ...[
            const SizedBox(width: 5),
            Text(label, style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}

// ── Reorderable active-slot list ───────────────────────────────────────────────

class _ActiveSlotsList extends StatelessWidget {
  const _ActiveSlotsList({required this.slots, required this.notifier});
  final List<String> slots;
  final NavSlotsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Fixed: Home
        _FixedTile(icon: Icons.home_rounded, label: 'Start', accent: TraumColors.coralOrange),

        // Reorderable slots
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (oldIndex, newIndex) {
            HapticFeedback.selectionClick();
            notifier.reorder(oldIndex, newIndex);
          },
          children: [
            for (int i = 0; i < slots.length; i++)
              Builder(
                key: ValueKey(slots[i]),
                builder: (_) {
                  final mod = _find(slots[i]);
                  final label = mod?.label ?? slots[i];
                  final icon = mod?.icon ?? Icons.widgets_rounded;
                  final ac = _accent(slots[i]);
                  return ListTile(
                    key: ValueKey(slots[i]),
                    leading: Icon(icon, color: ac),
                    title: Text(label),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline_rounded, color: Colors.redAccent),
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            notifier.removeSlot(slots[i]);
                          },
                        ),
                        const Icon(Icons.drag_handle_rounded, color: Colors.white38),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),

        // Add slot hint if under max
        if (slots.length < 4)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline_rounded, color: TraumColors.coralOrange.withValues(alpha: 0.6), size: 18),
                const SizedBox(width: 8),
                Text(
                  'Tippe auf ein Modul unten, um es hinzuzufügen (${slots.length}/4)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white38),
                ),
              ],
            ),
          ),

        // Fixed: More
        _FixedTile(icon: Icons.more_horiz_rounded, label: 'Mehr', accent: Colors.white38),
      ],
    );
  }
}

class _FixedTile extends StatelessWidget {
  const _FixedTile({required this.icon, required this.label, required this.accent});
  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: accent),
      title: Text(label),
      subtitle: const Text('Fixiert'),
      trailing: const Icon(Icons.lock_outline_rounded, color: Colors.white24, size: 18),
    );
  }
}

// ── Available module grid ──────────────────────────────────────────────────────

class _ModuleGrid extends StatelessWidget {
  const _ModuleGrid({required this.mods, required this.slots, required this.notifier});
  final List<_Mod> mods;
  final List<String> slots;
  final NavSlotsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final canAdd = slots.length < 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
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
          final ac = _accent(mod.key);
          return GestureDetector(
            onTap: canAdd
                ? () {
                    HapticFeedback.selectionClick();
                    notifier.addSlot(mod.key);
                  }
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: canAdd
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: canAdd
                      ? Colors.white.withValues(alpha: 0.10)
                      : Colors.white.withValues(alpha: 0.05),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    mod.icon,
                    size: 20,
                    color: canAdd ? ac : Colors.white24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      mod.label,
                      style: TextStyle(
                        color: canAdd ? Colors.white.withValues(alpha: 0.80) : Colors.white24,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (canAdd)
                    Icon(Icons.add_rounded, size: 16, color: ac.withValues(alpha: 0.6)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
