import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

final _shoppingListProvider = StreamProvider<List<ShoppingListItem>>((ref) {
  return ref.watch(nutritionRepositoryProvider).watchShoppingList();
});

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(_shoppingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einkaufsliste'),
        actions: [
          IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Erledigte löschen?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Abbrechen')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Löschen')),
                  ],
                ),
              );
              if (confirm == true) await ref.read(nutritionRepositoryProvider).clearCheckedItems();
            },
            icon: const Icon(Icons.delete_sweep_rounded),
          ),
        ],
      ),
      body: listAsync.when(
        data: (items) => items.isEmpty
            ? Center(child: Text('Liste ist leer', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TraumColors.onBackgroundMuted)))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final item = items[i];
                  return Dismissible(
                    key: ValueKey(item.id),
                    onDismissed: (_) => ref.read(nutritionRepositoryProvider).deleteShoppingItem(item.id),
                    child: TraumCard(
                      child: CheckboxListTile(
                        title: Text(item.name, style: TextStyle(decoration: item.checked ? TextDecoration.lineThrough : null)),
                        subtitle: item.category != null ? Text(item.category!) : null,
                        value: item.checked,
                        onChanged: (v) => ref.read(nutritionRepositoryProvider).updateShoppingItem(item.copyWith(checked: v ?? false)),
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Artikel hinzufügen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Artikel')),
            const SizedBox(height: 8),
            TextField(controller: categoryCtrl, decoration: const InputDecoration(labelText: 'Kategorie (optional)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty) return;
              await ref.read(nutritionRepositoryProvider).insertShoppingItem(
                    ShoppingListItemsCompanion.insert(
                      name: nameCtrl.text.trim(),
                      category: Value(categoryCtrl.text.trim().isEmpty ? null : categoryCtrl.text.trim()),
                    ),
                  );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Hinzufügen'),
          ),
        ],
      ),
    );
  }
}
