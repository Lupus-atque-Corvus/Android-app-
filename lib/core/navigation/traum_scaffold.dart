import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../components/traum_navigation_bar.dart';
import 'routes.dart';

const _rootRoutes = {
  Routes.home,
  Routes.training,
  Routes.health,
  Routes.nutrition,
  Routes.planning,
  Routes.supplements,
  Routes.medication,
  Routes.abstinence,
  Routes.budget,
  Routes.period,
  Routes.settings,
};

class TraumScaffold extends ConsumerWidget {
  const TraumScaffold({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeBottom = MediaQuery.of(context).padding.bottom;
    // Nav bar: ~60dp pill height + 12dp gap from screen bottom + system safe area
    final navSpace = 60.0 + 12.0 + safeBottom;
    final isRoot = _rootRoutes.contains(location);

    return PopScope(
      canPop: !isRoot,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (location == Routes.home) {
          SystemNavigator.pop();
        } else {
          context.go(Routes.home);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Override bottom padding so inner Scaffolds, SafeAreas and scroll
            // views automatically leave room for the floating nav bar.
            MediaQuery(
              data: MediaQuery.of(context).copyWith(
                padding: MediaQuery.of(context).padding.copyWith(
                  bottom: navSpace,
                ),
              ),
              child: child,
            ),
            TraumNavigationBar(location: location),
          ],
        ),
      ),
    );
  }
}
