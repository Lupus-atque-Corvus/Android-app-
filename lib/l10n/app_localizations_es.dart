// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String greetingMorning(String name) {
    return '¡Buenos días, $name!';
  }

  @override
  String greetingDay(String name) {
    return '¡Buenas tardes, $name!';
  }

  @override
  String greetingEvening(String name) {
    return '¡Buenas noches, $name!';
  }

  @override
  String greetingNight(String name) {
    return '¡Buenas noches, $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal pasos';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal kcal';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal g proteína';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal ml';
  }

  @override
  String get homeBudgetAvailable => 'Saldo disponible';

  @override
  String get homeNoAppointments => 'Sin citas hoy';

  @override
  String get homeNoGoal => 'Sin objetivo activo';

  @override
  String get homeTodayLabel => 'Hoy';

  @override
  String homeHabitsStreak(int days) {
    return 'Racha de $days días';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'y $count más';
  }

  @override
  String get homeHealthSleep => 'Sueño';

  @override
  String get homeHealthHeartRate => 'Frecuencia cardíaca';

  @override
  String get homeHealthMood => 'Estado de ánimo';

  @override
  String get homeWaterAdd200 => '+200 ml';

  @override
  String get homeWaterAdd300 => '+300 ml';

  @override
  String get homeWaterAdd500 => '+500 ml';

  @override
  String get navHome => 'Inicio';

  @override
  String get navTraining => 'Entrenamiento';

  @override
  String get navHealth => 'Salud';

  @override
  String get navNutrition => 'Nutrición';

  @override
  String get navMore => 'Más';

  @override
  String get navPlanning => 'Planificación';

  @override
  String get navMedication => 'Medicación';

  @override
  String get navSupplements => 'Suplementos';

  @override
  String get navAbstinence => 'Abstinencia';

  @override
  String get navBudget => 'Presupuesto';

  @override
  String get navPeriod => 'Ciclo';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get trainingStart => 'Iniciar entrenamiento';

  @override
  String get trainingHistory => 'Historial';

  @override
  String get trainingLastWorkout => 'Último entrenamiento';

  @override
  String get trainingActiveplan => 'Plan activo';

  @override
  String get trainingExerciseLibrary => 'Biblioteca de ejercicios';

  @override
  String get trainingExerciseProgress => 'Progreso';

  @override
  String get trainingVolume => 'Volumen';

  @override
  String get trainingDuration => 'Duración';

  @override
  String trainingSetCount(int current, int total) {
    return 'Serie $current de $total';
  }

  @override
  String get trainingRestTimer => 'Descanso';

  @override
  String get trainingWorkoutSummary => 'Entrenamiento completado';

  @override
  String get trainingAddExercise => 'Añadir ejercicio';

  @override
  String get trainingCustomExercise => 'Ejercicio personalizado';

  @override
  String get healthTitle => 'Salud';

  @override
  String get healthOverview => 'Resumen';

  @override
  String get healthSleep => 'Sueño';

  @override
  String get healthWeight => 'Peso';

  @override
  String get healthBodyMeasurements => 'Medidas corporales';

  @override
  String get healthSteps7Days => 'Tendencia 7 días';

  @override
  String get healthSleepManual => 'Introducir manualmente';

  @override
  String get healthSleepQuality => 'Calidad del sueño';

  @override
  String get healthWeightGoal => 'Peso objetivo';

  @override
  String get healthHeartRate => 'Frecuencia cardíaca en reposo';

  @override
  String get healthConnectPermission => 'Acceso Health Connect';

  @override
  String get healthKitPermission => 'Acceso Apple Health';

  @override
  String get healthNoData => 'Sin datos disponibles';

  @override
  String get nutritionTitle => 'Nutrición';

  @override
  String get nutritionCalories => 'Calorías';

  @override
  String get nutritionProtein => 'Proteína';

  @override
  String get nutritionCarbs => 'Carbohidratos';

  @override
  String get nutritionFat => 'Grasa';

  @override
  String get nutritionWater => 'Agua';

  @override
  String get nutritionAddMeal => 'Añadir comida';

  @override
  String get nutritionSaveTemplate => 'Guardar como plantilla';

  @override
  String get nutritionShoppingList => 'Lista de compras';

  @override
  String get supplementTitle => 'Suplementos';

  @override
  String get supplementAdd => 'Añadir suplemento';

  @override
  String get supplementTaken => 'Tomado';

  @override
  String get supplementPending => 'Pendiente';

  @override
  String get supplementHistory => 'Historial';

  @override
  String get medicationTitle => 'Medicación';

  @override
  String get medicationAdd => 'Añadir medicamento';

  @override
  String get medicationTaken => 'Tomado';

  @override
  String get medicationDose => 'Dosis';

  @override
  String get medicationCompliance => 'Cumplimiento';

  @override
  String get abstinenceTitle => 'Abstinencia';

  @override
  String get abstinenceAdd => 'Añadir rastreador';

  @override
  String abstinenceDays(int days) {
    return '$days días';
  }

  @override
  String get abstinenceRelapse => 'Recaída';

  @override
  String get abstinenceRelapseConfirm => 'Confirmar recaída';

  @override
  String get abstinenceRelapseNote => 'Nota (opcional)';

  @override
  String get abstinenceLongestStreak => 'Racha más larga';

  @override
  String get abstinenceLastRelapse => 'Última recaída';

  @override
  String get budgetTitle => 'Presupuesto';

  @override
  String get budgetAvailable => 'Saldo disponible';

  @override
  String get budgetIncome => 'Ingresos';

  @override
  String get budgetExpenses => 'Gastos';

  @override
  String get budgetCategoryExpenses => 'Gastos por categoría';

  @override
  String get budgetVsLimit => 'Presupuesto vs. gastos';

  @override
  String budgetOverrun(String category) {
    return '¡$category excedido!';
  }

  @override
  String get budgetAddTransaction => 'Añadir transacción';

  @override
  String get budgetSavings => 'Metas de ahorro';

  @override
  String get budgetDebts => 'Deudas';

  @override
  String get periodTitle => 'Ciclo';

  @override
  String periodDaysUntil(int days) {
    return 'Período en $days días';
  }

  @override
  String get periodFertile => 'Fértil';

  @override
  String get periodNotFertile => 'No fértil';

  @override
  String get periodOvulation => 'Ovulación';

  @override
  String get periodEnterPeriod => 'Registrar período';

  @override
  String get periodEnterSymptoms => 'Registrar síntomas';

  @override
  String get periodPregnancyChance => 'Probabilidad de embarazo';

  @override
  String get periodCalendar => 'Calendario';

  @override
  String get periodMyCycles => 'Mis ciclos';

  @override
  String get periodCycleTrends => 'Tendencias';

  @override
  String get planningTitle => 'Planificación';

  @override
  String get planningCalendar => 'Calendario';

  @override
  String get planningTodos => 'Tareas';

  @override
  String get planningGoals => 'Objetivos';

  @override
  String get planningHabits => 'Hábitos';

  @override
  String get planningAddAppointment => 'Añadir cita';

  @override
  String get planningAddTodo => 'Añadir tarea';

  @override
  String get planningAddGoal => 'Añadir objetivo';

  @override
  String get planningAddHabit => 'Añadir hábito';

  @override
  String get planningShowAll => 'Ver todo';

  @override
  String get planningDueDate => 'Fecha límite';

  @override
  String get planningPriorityHigh => 'Alta';

  @override
  String get planningPriorityMedium => 'Media';

  @override
  String get planningPriorityLow => 'Baja';

  @override
  String planningStreakDays(int days) {
    return '$days días';
  }

  @override
  String planningLongestStreak(int days) {
    return 'Racha más larga: $days días';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsWeightUnit => 'Peso';

  @override
  String get settingsLengthUnit => 'Longitud';

  @override
  String get settingsTempUnit => 'Temperatura';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsPrivacy => 'Privacidad y seguridad';

  @override
  String get settingsPinBiometric => 'PIN / Biometría';

  @override
  String get settingsExportData => 'Exportar datos';

  @override
  String get settingsBackup => 'Crear copia de seguridad';

  @override
  String get settingsRestore => 'Restaurar copia';

  @override
  String get settingsWeather => 'Tiempo';

  @override
  String get settingsNavigation => 'Personalizar navegación';

  @override
  String get settingsAccount => 'Cuenta y app';

  @override
  String get settingsPeriodTracking => 'Seguimiento menstrual';

  @override
  String get settingsResetOnboarding => 'Repetir introducción';

  @override
  String get settingsDeleteAllData => 'Eliminar todos los datos';

  @override
  String get settingsDeleteConfirmTitle => '¿Eliminar todos los datos?';

  @override
  String get settingsDeleteConfirmHint => 'Escribe ELIMINAR para confirmar';

  @override
  String get settingsWidgets => 'Widgets';

  @override
  String get settingsSupport => 'Soporte';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get supportBugReport => 'Reportar error';

  @override
  String get supportEmailCopied => 'Email copiado: support@traum-app.de';

  @override
  String get supportBugReportHint =>
      'Tu app de correo se abrirá con un borrador.';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido a TRAUM';

  @override
  String get onboardingWelcomeSubtitle =>
      'Tu sistema personal. Todo en un lugar.';

  @override
  String get onboardingProfileTitle => 'Tu perfil';

  @override
  String get onboardingProfilePrivacyNote =>
      'La siguiente información ayuda a TRAUM a personalizar la app. Todos los datos se guardan en tu dispositivo.';

  @override
  String get onboardingNameLabel => '¿Cómo te llamamos?';

  @override
  String get onboardingNameHint => 'Tu nombre';

  @override
  String get onboardingBirthday => 'Cumpleaños (opcional)';

  @override
  String get onboardingBiologicalSex => 'Sexo biológico';

  @override
  String get onboardingSexMale => 'Masculino';

  @override
  String get onboardingSexFemale => 'Femenino';

  @override
  String get onboardingSexNone => 'Prefiero no decir';

  @override
  String get onboardingPeriodActivated =>
      'El seguimiento menstrual se activará para ti.';

  @override
  String get onboardingUnits => 'Unidades';

  @override
  String get onboardingFitnessTitle => 'Fitness y salud';

  @override
  String get onboardingStepsGoal => 'Objetivo diario de pasos';

  @override
  String get onboardingCurrentWeight => 'Peso actual';

  @override
  String get onboardingTargetWeight => 'Peso objetivo';

  @override
  String get onboardingHeight => 'Altura';

  @override
  String get onboardingNutritionTitle => 'Nutrición';

  @override
  String get onboardingCalorieGoal => 'Objetivo calórico diario';

  @override
  String get onboardingProteinGoal => 'Objetivo de proteína diario (g)';

  @override
  String get onboardingWaterGoal => 'Objetivo de agua diario (ml)';

  @override
  String get onboardingNutritionHint =>
      'Puedes ajustar estos valores en ajustes en cualquier momento.';

  @override
  String get onboardingPeriodTitle => 'Tu ciclo';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM calcula tu ciclo, días fértiles e información relevante — sin nube, sin compartir datos.';

  @override
  String get onboardingLastPeriodStart =>
      'Primer día de la última menstruación';

  @override
  String get onboardingCycleLength => 'Duración media del ciclo';

  @override
  String get onboardingPeriodLength => 'Duración media de la menstruación';

  @override
  String get onboardingPeriodSetup => 'Configurar';

  @override
  String get onboardingPeriodLater => 'Configurar más tarde';

  @override
  String get onboardingNavTitle => 'Tu navegación';

  @override
  String get onboardingNavSubtitle =>
      'Elige qué módulos aparecen en tu barra de navegación.';

  @override
  String get onboardingHealthTitle => 'Datos de salud';

  @override
  String get onboardingHealthAndroid =>
      'TRAUM puede leer automáticamente pasos, sueño y frecuencia cardíaca de Health Connect.';

  @override
  String get onboardingHealthIOS =>
      'TRAUM puede leer automáticamente pasos, sueño y frecuencia cardíaca de Apple Health.';

  @override
  String get onboardingHealthAllow => 'Permitir acceso';

  @override
  String get onboardingHealthSkip => 'Más tarde';

  @override
  String get onboardingNotifTitle => 'Notificaciones';

  @override
  String get onboardingNotifSubtitle =>
      'Recordatorios para medicamentos, agua y tareas.';

  @override
  String get onboardingNotifAllow => 'Activar notificaciones';

  @override
  String get onboardingNotifSkip => 'No, gracias';

  @override
  String get onboardingDoneTitle => 'Todo listo.';

  @override
  String get onboardingDoneSubtitle =>
      'Tu sistema te espera. Puedes ajustar todo en ajustes.';

  @override
  String get onboardingDoneHint =>
      'Tus datos nunca saldrán de este dispositivo.';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingFinish => '¡Empecemos!';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonAdd => 'Añadir';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonShowAll => 'Ver todo';

  @override
  String get commonNoData => 'Sin datos';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get commonError => 'Error';

  @override
  String get commonSuccess => 'Guardado con éxito';

  @override
  String commonDays(int count) {
    return '$count días';
  }

  @override
  String commonHours(int count) {
    return '$count horas';
  }

  @override
  String commonMinutes(int count) {
    return '$count minutos';
  }

  @override
  String get notifMedication => 'Medicación';

  @override
  String get notifSupplement => 'Suplementos';

  @override
  String get notifWorkout => 'Entrenamiento';

  @override
  String get notifWater => 'Agua';

  @override
  String get notifTodo => 'Tareas';

  @override
  String get notifHabit => 'Hábitos';

  @override
  String get notifCalendar => 'Calendario';

  @override
  String get notifHealth => 'Salud';

  @override
  String get notifBudget => 'Presupuesto';

  @override
  String get notifPeriod => 'Ciclo';

  @override
  String get exercise_bench_press => 'Press de banca (barra)';

  @override
  String get exercise_push_up => 'Flexiones';

  @override
  String get exercise_pull_up => 'Dominadas';

  @override
  String get exercise_squat => 'Sentadilla';

  @override
  String get exercise_deadlift => 'Peso muerto';

  @override
  String get exercise_shoulder_press => 'Press de hombros';

  @override
  String get exercise_bicep_curl => 'Curl de bíceps';

  @override
  String get exercise_tricep_dip => 'Fondos de tríceps';

  @override
  String get exercise_plank => 'Plancha';

  @override
  String get exercise_running => 'Correr';

  @override
  String get exercise_incline_press => 'Press inclinado';

  @override
  String get exercise_chest_fly => 'Aperturas';

  @override
  String get exercise_cable_crossover => 'Cruce de poleas';

  @override
  String get exercise_dip => 'Fondos';

  @override
  String get exercise_lat_pulldown => 'Jalón al pecho';

  @override
  String get exercise_bent_row => 'Remo inclinado';

  @override
  String get exercise_seated_row => 'Remo sentado';

  @override
  String get exercise_pullover => 'Pullover';

  @override
  String get exercise_face_pull => 'Face pull';

  @override
  String get exercise_lateral_raise => 'Elevaciones laterales';

  @override
  String get exercise_front_raise => 'Elevaciones frontales';

  @override
  String get exercise_rear_delt_fly => 'Aperturas posteriores';

  @override
  String get exercise_hammer_curl => 'Curl martillo';

  @override
  String get exercise_concentration_curl => 'Curl concentrado';

  @override
  String get exercise_skull_crusher => 'Rompe cráneos';

  @override
  String get exercise_overhead_tricep => 'Extensión tríceps';

  @override
  String get exercise_leg_press => 'Prensa de piernas';

  @override
  String get exercise_leg_curl => 'Curl de piernas';

  @override
  String get exercise_leg_extension => 'Extensión de piernas';

  @override
  String get exercise_calf_raise => 'Elevación de talones';

  @override
  String get exercise_lunge => 'Zancada';

  @override
  String get exercise_glute_bridge => 'Puente de glúteos';

  @override
  String get exercise_crunch => 'Crunch';

  @override
  String get exercise_russian_twist => 'Giro ruso';

  @override
  String get exercise_leg_raise => 'Elevación de piernas';

  @override
  String get exercise_mountain_climber => 'Escalador';

  @override
  String get exercise_bicycle_crunch => 'Crunch bicicleta';

  @override
  String get exercise_cycling => 'Ciclismo';

  @override
  String get exercise_rowing => 'Remo';

  @override
  String get exercise_jump_rope => 'Saltar a la comba';

  @override
  String get exercise_burpee => 'Burpee';

  @override
  String get exercise_jumping_jack => 'Jumping jack';

  @override
  String get exercise_clean => 'Clean';

  @override
  String get exercise_snatch => 'Arrancada';

  @override
  String get exercise_thruster => 'Thruster';

  @override
  String get exercise_box_jump => 'Salto al cajón';

  @override
  String get exercise_battle_rope => 'Battle rope';

  @override
  String get supplement_vitamin_d3 => 'Vitamina D3';

  @override
  String get supplement_vitamin_c => 'Vitamina C';

  @override
  String get supplement_vitamin_b12 => 'Vitamina B12';

  @override
  String get supplement_vitamin_a => 'Vitamina A';

  @override
  String get supplement_vitamin_e => 'Vitamina E';

  @override
  String get supplement_vitamin_k2 => 'Vitamina K2';

  @override
  String get supplement_vitamin_b_complex => 'Complejo de Vitamina B';

  @override
  String get supplement_magnesium => 'Magnesio';

  @override
  String get supplement_zinc => 'Zinc';

  @override
  String get supplement_iron => 'Hierro';

  @override
  String get supplement_calcium => 'Calcio';

  @override
  String get supplement_selenium => 'Selenio';

  @override
  String get supplement_creatine => 'Creatina';

  @override
  String get supplement_l_glutamine => 'L-Glutamina';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-Arginina';

  @override
  String get supplement_whey_protein => 'Proteína de suero';

  @override
  String get supplement_casein => 'Caseína';

  @override
  String get supplement_vegan_protein => 'Proteína vegana';

  @override
  String get supplement_omega3 => 'Omega-3';

  @override
  String get supplement_fish_oil => 'Aceite de pescado';

  @override
  String get supplement_ashwagandha => 'Ashwagandha';

  @override
  String get supplement_rhodiola => 'Rhodiola';

  @override
  String get supplement_caffeine => 'Cafeína';

  @override
  String get supplement_beta_alanine => 'Beta-alanina';

  @override
  String get supplement_citrulline => 'Citrulina';

  @override
  String get supplement_probiotics => 'Probióticos';

  @override
  String get supplement_prebiotics => 'Prebióticos';
}
