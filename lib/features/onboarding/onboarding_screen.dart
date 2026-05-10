import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/navigation/routes.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/components/components.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Profile fields
  final _nameController = TextEditingController();
  DateTime? _birthday;
  String _biologicalSex = 'other';
  String _unitSystem = 'metric';

  // Fitness goals
  int _stepsGoal = 10000;
  double _weightGoalKg = 75.0;
  double _heightCm = 175.0;

  // Nutrition goals
  int _kcalGoal = 2000;
  int _proteinGoalG = 150;
  int _waterGoalMl = 2500;

  // Nav slots (5 selected from all modules)
  final List<String> _navSlots = ['home', 'training', 'health', 'nutrition', 'planning'];

  // Period setup
  int _avgCycleLength = 28;
  int _avgPeriodLength = 5;

  List<Widget> get _pages {
    final pages = <Widget>[
      _WelcomePage(onNext: _nextPage),
      _ProfilePage(
        nameController: _nameController,
        birthday: _birthday,
        onBirthdayChanged: (d) => setState(() => _birthday = d),
        biologicalSex: _biologicalSex,
        onSexChanged: (s) => setState(() => _biologicalSex = s),
        unitSystem: _unitSystem,
        onUnitChanged: (u) => setState(() => _unitSystem = u),
        onNext: _nextPage,
      ),
      _FitnessGoalsPage(
        stepsGoal: _stepsGoal,
        onStepsChanged: (v) => setState(() => _stepsGoal = v),
        weightGoal: _weightGoalKg,
        onWeightChanged: (v) => setState(() => _weightGoalKg = v),
        heightCm: _heightCm,
        onHeightChanged: (v) => setState(() => _heightCm = v),
        onNext: _nextPage,
      ),
      _NutritionGoalsPage(
        kcalGoal: _kcalGoal,
        onKcalChanged: (v) => setState(() => _kcalGoal = v),
        proteinGoal: _proteinGoalG,
        onProteinChanged: (v) => setState(() => _proteinGoalG = v),
        waterGoal: _waterGoalMl,
        onWaterChanged: (v) => setState(() => _waterGoalMl = v),
        onNext: _nextPage,
      ),
      if (_biologicalSex == 'female')
        _PeriodSetupPage(
          cycleLength: _avgCycleLength,
          onCycleLengthChanged: (v) => setState(() => _avgCycleLength = v),
          periodLength: _avgPeriodLength,
          onPeriodLengthChanged: (v) => setState(() => _avgPeriodLength = v),
          onNext: _nextPage,
        ),
      _NavSlotsPage(
        slots: _navSlots,
        onSlotsChanged: (s) => setState(() {
          _navSlots.clear();
          _navSlots.addAll(s);
        }),
        onNext: _nextPage,
      ),
      _DonePage(onFinish: _finish),
    ];
    return pages;
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finish() async {
    final prefs = ref.read(preferencesRepositoryProvider);
    await prefs.setUserName(_nameController.text.trim());
    if (_birthday != null) await prefs.setUserBirthday(_birthday!);
    await prefs.setUserBiologicalSex(_biologicalSex);
    await prefs.setUnitSystem(_unitSystem);
    await prefs.setStepsGoal(_stepsGoal);
    await prefs.setWeightGoalKg(_weightGoalKg);
    await prefs.setHeightCm(_heightCm);
    await prefs.setKcalGoal(_kcalGoal);
    await prefs.setProteinGoalG(_proteinGoalG);
    await prefs.setWaterGoalMl(_waterGoalMl);
    if (_biologicalSex == 'female') {
      await prefs.setAvgCycleLength(_avgCycleLength);
      await prefs.setAvgPeriodLength(_avgPeriodLength);
    }
    await prefs.setNavSlots('[${_navSlots.map((s) => '"$s"').join(',')}]');
    await prefs.setOnboardingComplete(true);
    if (mounted) context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pages;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _currentPage ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _currentPage
                          ? TraumColors.coralOrange
                          : TraumColors.onBackgroundSubtle,
                      borderRadius: TraumRadius.chip,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}

// ── Pages ─────────────────────────────────────────────────────────────────────

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_awesome_rounded,
              size: 80, color: TraumColors.coralOrange),
          const SizedBox(height: 24),
          Text(
            'Willkommen bei TRAUM',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Dein persönliches Lebens-Dashboard. Verwalte Training, Gesundheit, Ernährung und mehr — alles an einem Ort.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          GradientButton(
            label: 'Loslegen',
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({
    required this.nameController,
    required this.birthday,
    required this.onBirthdayChanged,
    required this.biologicalSex,
    required this.onSexChanged,
    required this.unitSystem,
    required this.onUnitChanged,
    required this.onNext,
  });

  final TextEditingController nameController;
  final DateTime? birthday;
  final void Function(DateTime) onBirthdayChanged;
  final String biologicalSex;
  final void Function(String) onSexChanged;
  final String unitSystem;
  final void Function(String) onUnitChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dein Profil', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Geburtstag'),
            subtitle: Text(birthday != null
                ? '${birthday!.day}.${birthday!.month}.${birthday!.year}'
                : 'Nicht angegeben'),
            trailing: const Icon(Icons.calendar_today_rounded),
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: birthday ?? DateTime(1990),
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
              );
              if (d != null) onBirthdayChanged(d);
            },
          ),
          const SizedBox(height: 16),
          Text('Biologisches Geschlecht',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'male', label: Text('Männlich')),
              ButtonSegment(value: 'female', label: Text('Weiblich')),
              ButtonSegment(value: 'other', label: Text('Divers')),
            ],
            selected: {biologicalSex},
            onSelectionChanged: (s) => onSexChanged(s.first),
          ),
          const SizedBox(height: 16),
          Text('Einheitensystem', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'metric', label: Text('Metrisch')),
              ButtonSegment(value: 'imperial', label: Text('Imperial')),
            ],
            selected: {unitSystem},
            onSelectionChanged: (s) => onUnitChanged(s.first),
          ),
          const SizedBox(height: 32),
          GradientButton(label: 'Weiter', onPressed: onNext),
        ],
      ),
    );
  }
}

class _FitnessGoalsPage extends StatelessWidget {
  const _FitnessGoalsPage({
    required this.stepsGoal,
    required this.onStepsChanged,
    required this.weightGoal,
    required this.onWeightChanged,
    required this.heightCm,
    required this.onHeightChanged,
    required this.onNext,
  });

  final int stepsGoal;
  final void Function(int) onStepsChanged;
  final double weightGoal;
  final void Function(double) onWeightChanged;
  final double heightCm;
  final void Function(double) onHeightChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fitnessziele', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          _SliderTile(
            label: 'Schritte/Tag',
            value: stepsGoal.toDouble(),
            min: 2000,
            max: 30000,
            divisions: 28,
            display: '$stepsGoal',
            onChanged: (v) => onStepsChanged(v.round()),
          ),
          _SliderTile(
            label: 'Zielgewicht (kg)',
            value: weightGoal,
            min: 30,
            max: 200,
            display: '${weightGoal.toStringAsFixed(1)} kg',
            onChanged: (v) => onWeightChanged(double.parse(v.toStringAsFixed(1))),
          ),
          _SliderTile(
            label: 'Körpergröße (cm)',
            value: heightCm,
            min: 100,
            max: 250,
            display: '${heightCm.toStringAsFixed(0)} cm',
            onChanged: (v) => onHeightChanged(v),
          ),
          const SizedBox(height: 32),
          GradientButton(label: 'Weiter', onPressed: onNext),
        ],
      ),
    );
  }
}

class _NutritionGoalsPage extends StatelessWidget {
  const _NutritionGoalsPage({
    required this.kcalGoal,
    required this.onKcalChanged,
    required this.proteinGoal,
    required this.onProteinChanged,
    required this.waterGoal,
    required this.onWaterChanged,
    required this.onNext,
  });

  final int kcalGoal;
  final void Function(int) onKcalChanged;
  final int proteinGoal;
  final void Function(int) onProteinChanged;
  final int waterGoal;
  final void Function(int) onWaterChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ernährungsziele', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          _SliderTile(
            label: 'Kalorien (kcal)',
            value: kcalGoal.toDouble(),
            min: 800,
            max: 5000,
            divisions: 42,
            display: '$kcalGoal kcal',
            onChanged: (v) => onKcalChanged(v.round()),
          ),
          _SliderTile(
            label: 'Protein (g)',
            value: proteinGoal.toDouble(),
            min: 30,
            max: 300,
            divisions: 27,
            display: '$proteinGoal g',
            onChanged: (v) => onProteinChanged(v.round()),
          ),
          _SliderTile(
            label: 'Wasser (ml)',
            value: waterGoal.toDouble(),
            min: 1000,
            max: 5000,
            divisions: 40,
            display: '$waterGoal ml',
            onChanged: (v) => onWaterChanged(v.round()),
          ),
          const SizedBox(height: 32),
          GradientButton(label: 'Weiter', onPressed: onNext),
        ],
      ),
    );
  }
}

class _PeriodSetupPage extends StatelessWidget {
  const _PeriodSetupPage({
    required this.cycleLength,
    required this.onCycleLengthChanged,
    required this.periodLength,
    required this.onPeriodLengthChanged,
    required this.onNext,
  });

  final int cycleLength;
  final void Function(int) onCycleLengthChanged;
  final int periodLength;
  final void Function(int) onPeriodLengthChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Zykluseinstellungen',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          _SliderTile(
            label: 'Durchschnittliche Zykluslänge (Tage)',
            value: cycleLength.toDouble(),
            min: 20,
            max: 45,
            divisions: 25,
            display: '$cycleLength Tage',
            onChanged: (v) => onCycleLengthChanged(v.round()),
          ),
          _SliderTile(
            label: 'Durchschnittliche Periodendauer (Tage)',
            value: periodLength.toDouble(),
            min: 2,
            max: 10,
            divisions: 8,
            display: '$periodLength Tage',
            onChanged: (v) => onPeriodLengthChanged(v.round()),
          ),
          const SizedBox(height: 32),
          GradientButton(label: 'Weiter', onPressed: onNext),
        ],
      ),
    );
  }
}

class _NavSlotsPage extends StatefulWidget {
  const _NavSlotsPage({
    required this.slots,
    required this.onSlotsChanged,
    required this.onNext,
  });

  final List<String> slots;
  final void Function(List<String>) onSlotsChanged;
  final VoidCallback onNext;

  @override
  State<_NavSlotsPage> createState() => _NavSlotsPageState();
}

class _NavSlotsPageState extends State<_NavSlotsPage> {
  static const _allModules = [
    ('home', 'Start'),
    ('training', 'Training'),
    ('health', 'Gesundheit'),
    ('nutrition', 'Ernährung'),
    ('planning', 'Planung'),
    ('supplements', 'Supplemente'),
    ('medication', 'Medikamente'),
    ('abstinence', 'Abstinenz'),
    ('budget', 'Budget'),
    ('period', 'Zyklus'),
    ('settings', 'Einstellungen'),
  ];

  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.slots);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Navigation', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Wähle 5 Module für die untere Navigationsleiste.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _allModules.map((m) {
              final selected = _selected.contains(m.$1);
              return FilterChip(
                label: Text(m.$2),
                selected: selected,
                onSelected: (v) {
                  setState(() {
                    if (v && _selected.length < 5) {
                      _selected.add(m.$1);
                    } else if (!v && m.$1 != 'home') {
                      _selected.remove(m.$1);
                    }
                  });
                  widget.onSlotsChanged(_selected);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          GradientButton(
            label: 'Weiter',
            onPressed: _selected.length == 5 ? widget.onNext : null,
          ),
        ],
      ),
    );
  }
}

class _DonePage extends StatelessWidget {
  const _DonePage({required this.onFinish});
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_rounded,
              size: 80, color: TraumColors.success),
          const SizedBox(height: 24),
          Text('Alles bereit!', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(
            'TRAUM ist eingerichtet. Du kannst jederzeit alles in den Einstellungen anpassen.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          GradientButton(label: "Los geht's", onPressed: onFinish),
        ],
      ),
    );
  }
}

// ── Helper widget ─────────────────────────────────────────────────────────────

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.display,
    required this.onChanged,
    this.divisions,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String display;
  final void Function(double) onChanged;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(display,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: TraumColors.coralOrange)),
          ],
        ),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
