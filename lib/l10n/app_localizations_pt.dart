// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'Bom dia, $name!';
  }

  @override
  String greetingDay(String name) {
    return 'Boa tarde, $name!';
  }

  @override
  String greetingEvening(String name) {
    return 'Boa noite, $name!';
  }

  @override
  String greetingNight(String name) {
    return 'Boa noite, $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal passos';
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
  String get homeBudgetAvailable => 'Saldo disponível';

  @override
  String get homeNoAppointments => 'Sem compromissos hoje';

  @override
  String get homeNoGoal => 'Sem objetivo ativo';

  @override
  String get homeTodayLabel => 'Hoje';

  @override
  String homeHabitsStreak(int days) {
    return 'Sequência de $days dias';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'e mais $count';
  }

  @override
  String get homeHealthSleep => 'Sono';

  @override
  String get homeHealthHeartRate => 'Frequência cardíaca';

  @override
  String get homeHealthMood => 'Humor';

  @override
  String get homeWaterAdd200 => '+200 ml';

  @override
  String get homeWaterAdd300 => '+300 ml';

  @override
  String get homeWaterAdd500 => '+500 ml';

  @override
  String get navHome => 'Início';

  @override
  String get navTraining => 'Treino';

  @override
  String get navHealth => 'Saúde';

  @override
  String get navNutrition => 'Nutrição';

  @override
  String get navMore => 'Mais';

  @override
  String get navPlanning => 'Planejamento';

  @override
  String get navMedication => 'Medicação';

  @override
  String get navSupplements => 'Suplementos';

  @override
  String get navAbstinence => 'Abstinência';

  @override
  String get navBudget => 'Orçamento';

  @override
  String get navPeriod => 'Ciclo';

  @override
  String get navSettings => 'Configurações';

  @override
  String get trainingStart => 'Iniciar treino';

  @override
  String get trainingHistory => 'Histórico de treinos';

  @override
  String get trainingLastWorkout => 'Último treino';

  @override
  String get trainingActiveplan => 'Plano ativo';

  @override
  String get trainingExerciseLibrary => 'Biblioteca de exercícios';

  @override
  String get trainingExerciseProgress => 'Progresso';

  @override
  String get trainingVolume => 'Volume';

  @override
  String get trainingDuration => 'Duração';

  @override
  String trainingSetCount(int current, int total) {
    return 'Série $current de $total';
  }

  @override
  String get trainingRestTimer => 'Descanso';

  @override
  String get trainingWorkoutSummary => 'Treino concluído';

  @override
  String get trainingAddExercise => 'Adicionar exercício';

  @override
  String get trainingCustomExercise => 'Exercício personalizado';

  @override
  String get healthTitle => 'Saúde';

  @override
  String get healthOverview => 'Visão geral';

  @override
  String get healthSleep => 'Sono';

  @override
  String get healthWeight => 'Peso';

  @override
  String get healthBodyMeasurements => 'Medidas corporais';

  @override
  String get healthSteps7Days => 'Tendência 7 dias';

  @override
  String get healthSleepManual => 'Inserir manualmente';

  @override
  String get healthSleepQuality => 'Qualidade do sono';

  @override
  String get healthWeightGoal => 'Peso alvo';

  @override
  String get healthHeartRate => 'Frequência cardíaca em repouso';

  @override
  String get healthConnectPermission => 'Acesso Health Connect';

  @override
  String get healthKitPermission => 'Acesso Apple Health';

  @override
  String get healthNoData => 'Sem dados disponíveis';

  @override
  String get nutritionTitle => 'Nutrição';

  @override
  String get nutritionCalories => 'Calorias';

  @override
  String get nutritionProtein => 'Proteína';

  @override
  String get nutritionCarbs => 'Carboidratos';

  @override
  String get nutritionFat => 'Gordura';

  @override
  String get nutritionWater => 'Água';

  @override
  String get nutritionAddMeal => 'Adicionar refeição';

  @override
  String get nutritionSaveTemplate => 'Salvar como modelo';

  @override
  String get nutritionShoppingList => 'Lista de compras';

  @override
  String get supplementTitle => 'Suplementos';

  @override
  String get supplementAdd => 'Adicionar suplemento';

  @override
  String get supplementTaken => 'Tomado';

  @override
  String get supplementPending => 'Pendente';

  @override
  String get supplementHistory => 'Histórico';

  @override
  String get medicationTitle => 'Medicação';

  @override
  String get medicationAdd => 'Adicionar medicamento';

  @override
  String get medicationTaken => 'Tomado';

  @override
  String get medicationDose => 'Dose';

  @override
  String get medicationCompliance => 'Adesão';

  @override
  String get abstinenceTitle => 'Abstinência';

  @override
  String get abstinenceAdd => 'Adicionar rastreador';

  @override
  String abstinenceDays(int days) {
    return '$days dias';
  }

  @override
  String get abstinenceRelapse => 'Recaída';

  @override
  String get abstinenceRelapseConfirm => 'Confirmar recaída';

  @override
  String get abstinenceRelapseNote => 'Nota (opcional)';

  @override
  String get abstinenceLongestStreak => 'Maior sequência';

  @override
  String get abstinenceLastRelapse => 'Última recaída';

  @override
  String get budgetTitle => 'Orçamento';

  @override
  String get budgetAvailable => 'Saldo disponível';

  @override
  String get budgetIncome => 'Receitas';

  @override
  String get budgetExpenses => 'Despesas';

  @override
  String get budgetCategoryExpenses => 'Despesas por categoria';

  @override
  String get budgetVsLimit => 'Orçamento vs. despesas';

  @override
  String budgetOverrun(String category) {
    return '$category excedido!';
  }

  @override
  String get budgetAddTransaction => 'Adicionar transação';

  @override
  String get budgetSavings => 'Metas de poupança';

  @override
  String get budgetDebts => 'Dívidas';

  @override
  String get periodTitle => 'Ciclo';

  @override
  String periodDaysUntil(int days) {
    return 'Período em $days dias';
  }

  @override
  String get periodFertile => 'Fértil';

  @override
  String get periodNotFertile => 'Não fértil';

  @override
  String get periodOvulation => 'Ovulação';

  @override
  String get periodEnterPeriod => 'Registrar período';

  @override
  String get periodEnterSymptoms => 'Registrar sintomas';

  @override
  String get periodPregnancyChance => 'Probabilidade de gravidez';

  @override
  String get periodCalendar => 'Calendário';

  @override
  String get periodMyCycles => 'Meus ciclos';

  @override
  String get periodCycleTrends => 'Tendências';

  @override
  String get planningTitle => 'Planejamento';

  @override
  String get planningCalendar => 'Calendário';

  @override
  String get planningTodos => 'Tarefas';

  @override
  String get planningGoals => 'Metas';

  @override
  String get planningHabits => 'Hábitos';

  @override
  String get planningAddAppointment => 'Adicionar compromisso';

  @override
  String get planningAddTodo => 'Adicionar tarefa';

  @override
  String get planningAddGoal => 'Adicionar meta';

  @override
  String get planningAddHabit => 'Adicionar hábito';

  @override
  String get planningShowAll => 'Ver todos';

  @override
  String get planningDueDate => 'Prazo';

  @override
  String get planningPriorityHigh => 'Alta';

  @override
  String get planningPriorityMedium => 'Média';

  @override
  String get planningPriorityLow => 'Baixa';

  @override
  String planningStreakDays(int days) {
    return '$days dias';
  }

  @override
  String planningLongestStreak(int days) {
    return 'Maior sequência: $days dias';
  }

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeDark => 'Escuro';

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
  String get settingsLengthUnit => 'Comprimento';

  @override
  String get settingsTempUnit => 'Temperatura';

  @override
  String get settingsNotifications => 'Notificações';

  @override
  String get settingsPrivacy => 'Privacidade e segurança';

  @override
  String get settingsPinBiometric => 'PIN / Biometria';

  @override
  String get settingsExportData => 'Exportar dados';

  @override
  String get settingsBackup => 'Criar backup';

  @override
  String get settingsRestore => 'Restaurar backup';

  @override
  String get settingsWeather => 'Clima';

  @override
  String get settingsNavigation => 'Personalizar navegação';

  @override
  String get settingsAccount => 'Conta e app';

  @override
  String get settingsPeriodTracking => 'Rastreamento menstrual';

  @override
  String get settingsResetOnboarding => 'Repetir introdução';

  @override
  String get settingsDeleteAllData => 'Excluir todos os dados';

  @override
  String get settingsDeleteConfirmTitle => 'Excluir todos os dados?';

  @override
  String get settingsDeleteConfirmHint => 'Digite EXCLUIR para confirmar';

  @override
  String get settingsWidgets => 'Widgets';

  @override
  String get settingsSupport => 'Suporte';

  @override
  String get settingsVersion => 'Versão do app';

  @override
  String get supportBugReport => 'Reportar erro';

  @override
  String get supportEmailCopied => 'Email copiado: support@traum-app.de';

  @override
  String get supportBugReportHint => 'Seu app de email abrirá com um rascunho.';

  @override
  String get onboardingWelcomeTitle => 'Bem-vindo ao TRAUM';

  @override
  String get onboardingWelcomeSubtitle =>
      'Seu sistema pessoal. Tudo em um só lugar.';

  @override
  String get onboardingProfileTitle => 'Seu perfil';

  @override
  String get onboardingProfilePrivacyNote =>
      'As informações a seguir ajudam o TRAUM a personalizar o app. Todos os dados ficam no seu dispositivo.';

  @override
  String get onboardingNameLabel => 'Como devemos te chamar?';

  @override
  String get onboardingNameHint => 'Seu nome';

  @override
  String get onboardingBirthday => 'Aniversário (opcional)';

  @override
  String get onboardingBiologicalSex => 'Sexo biológico';

  @override
  String get onboardingSexMale => 'Masculino';

  @override
  String get onboardingSexFemale => 'Feminino';

  @override
  String get onboardingSexNone => 'Prefiro não dizer';

  @override
  String get onboardingPeriodActivated =>
      'O rastreamento menstrual será ativado para você.';

  @override
  String get onboardingUnits => 'Unidades';

  @override
  String get onboardingFitnessTitle => 'Fitness e saúde';

  @override
  String get onboardingStepsGoal => 'Meta diária de passos';

  @override
  String get onboardingCurrentWeight => 'Peso atual';

  @override
  String get onboardingTargetWeight => 'Peso alvo';

  @override
  String get onboardingHeight => 'Altura';

  @override
  String get onboardingNutritionTitle => 'Nutrição';

  @override
  String get onboardingCalorieGoal => 'Meta calórica diária';

  @override
  String get onboardingProteinGoal => 'Meta de proteína diária (g)';

  @override
  String get onboardingWaterGoal => 'Meta de água diária (ml)';

  @override
  String get onboardingNutritionHint =>
      'Você pode ajustar esses valores nas configurações a qualquer momento.';

  @override
  String get onboardingPeriodTitle => 'Seu ciclo';

  @override
  String get onboardingPeriodSubtitle =>
      'O TRAUM calcula seu ciclo e dias férteis — sem nuvem, sem compartilhamento.';

  @override
  String get onboardingLastPeriodStart => 'Primeiro dia do último período';

  @override
  String get onboardingCycleLength => 'Duração média do ciclo';

  @override
  String get onboardingPeriodLength => 'Duração média do período';

  @override
  String get onboardingPeriodSetup => 'Configurar';

  @override
  String get onboardingPeriodLater => 'Configurar depois';

  @override
  String get onboardingNavTitle => 'Sua navegação';

  @override
  String get onboardingNavSubtitle =>
      'Escolha quais módulos aparecem na sua barra de navegação.';

  @override
  String get onboardingHealthTitle => 'Dados de saúde';

  @override
  String get onboardingHealthAndroid =>
      'O TRAUM pode ler automaticamente passos, sono e frequência cardíaca do Health Connect.';

  @override
  String get onboardingHealthIOS =>
      'O TRAUM pode ler automaticamente passos, sono e frequência cardíaca do Apple Health.';

  @override
  String get onboardingHealthAllow => 'Permitir acesso';

  @override
  String get onboardingHealthSkip => 'Mais tarde';

  @override
  String get onboardingNotifTitle => 'Notificações';

  @override
  String get onboardingNotifSubtitle =>
      'Lembretes para medicamentos, água e tarefas.';

  @override
  String get onboardingNotifAllow => 'Ativar notificações';

  @override
  String get onboardingNotifSkip => 'Não, obrigado';

  @override
  String get onboardingDoneTitle => 'Tudo pronto.';

  @override
  String get onboardingDoneSubtitle =>
      'Seu sistema está esperando. Você pode ajustar tudo nas configurações.';

  @override
  String get onboardingDoneHint => 'Seus dados nunca sairão deste dispositivo.';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingFinish => 'Vamos lá!';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonAdd => 'Adicionar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonShowAll => 'Ver tudo';

  @override
  String get commonNoData => 'Sem dados';

  @override
  String get commonLoading => 'Carregando…';

  @override
  String get commonError => 'Erro';

  @override
  String get commonSuccess => 'Salvo com sucesso';

  @override
  String commonDays(int count) {
    return '$count dias';
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
  String get notifMedication => 'Medicação';

  @override
  String get notifSupplement => 'Suplementos';

  @override
  String get notifWorkout => 'Treino';

  @override
  String get notifWater => 'Água';

  @override
  String get notifTodo => 'Tarefas';

  @override
  String get notifHabit => 'Hábitos';

  @override
  String get notifCalendar => 'Calendário';

  @override
  String get notifHealth => 'Saúde';

  @override
  String get notifBudget => 'Orçamento';

  @override
  String get notifPeriod => 'Ciclo';

  @override
  String get exercise_bench_press => 'Supino (barra)';

  @override
  String get exercise_push_up => 'Flexão';

  @override
  String get exercise_pull_up => 'Barra fixa';

  @override
  String get exercise_squat => 'Agachamento';

  @override
  String get exercise_deadlift => 'Levantamento terra';

  @override
  String get exercise_shoulder_press => 'Desenvolvimento';

  @override
  String get exercise_bicep_curl => 'Rosca direta';

  @override
  String get exercise_tricep_dip => 'Mergulho tríceps';

  @override
  String get exercise_plank => 'Prancha';

  @override
  String get exercise_running => 'Corrida';

  @override
  String get exercise_incline_press => 'Supino inclinado';

  @override
  String get exercise_chest_fly => 'Crucifixo';

  @override
  String get exercise_cable_crossover => 'Crossover';

  @override
  String get exercise_dip => 'Mergulho';

  @override
  String get exercise_lat_pulldown => 'Puxada frontal';

  @override
  String get exercise_bent_row => 'Remada curvada';

  @override
  String get exercise_seated_row => 'Remada sentado';

  @override
  String get exercise_pullover => 'Pullover';

  @override
  String get exercise_face_pull => 'Face pull';

  @override
  String get exercise_lateral_raise => 'Elevação lateral';

  @override
  String get exercise_front_raise => 'Elevação frontal';

  @override
  String get exercise_rear_delt_fly => 'Crucifixo invertido';

  @override
  String get exercise_hammer_curl => 'Rosca martelo';

  @override
  String get exercise_concentration_curl => 'Rosca concentrada';

  @override
  String get exercise_skull_crusher => 'Tríceps testa';

  @override
  String get exercise_overhead_tricep => 'Tríceps tronco';

  @override
  String get exercise_leg_press => 'Leg press';

  @override
  String get exercise_leg_curl => 'Flexão de pernas';

  @override
  String get exercise_leg_extension => 'Extensão de pernas';

  @override
  String get exercise_calf_raise => 'Panturrilha em pé';

  @override
  String get exercise_lunge => 'Avanço';

  @override
  String get exercise_glute_bridge => 'Ponte glúteo';

  @override
  String get exercise_crunch => 'Abdominal';

  @override
  String get exercise_russian_twist => 'Torção russa';

  @override
  String get exercise_leg_raise => 'Elevação de pernas';

  @override
  String get exercise_mountain_climber => 'Escalador';

  @override
  String get exercise_bicycle_crunch => 'Abdominal bicicleta';

  @override
  String get exercise_cycling => 'Ciclismo';

  @override
  String get exercise_rowing => 'Remo';

  @override
  String get exercise_jump_rope => 'Corda';

  @override
  String get exercise_burpee => 'Burpee';

  @override
  String get exercise_jumping_jack => 'Polichinelo';

  @override
  String get exercise_clean => 'Clean';

  @override
  String get exercise_snatch => 'Arremesso';

  @override
  String get exercise_thruster => 'Thruster';

  @override
  String get exercise_box_jump => 'Salto na caixa';

  @override
  String get exercise_battle_rope => 'Corda de batalha';

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
  String get supplement_vitamin_b_complex => 'Complexo B';

  @override
  String get supplement_magnesium => 'Magnésio';

  @override
  String get supplement_zinc => 'Zinco';

  @override
  String get supplement_iron => 'Ferro';

  @override
  String get supplement_calcium => 'Cálcio';

  @override
  String get supplement_selenium => 'Selênio';

  @override
  String get supplement_creatine => 'Creatina';

  @override
  String get supplement_l_glutamine => 'L-Glutamina';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-Arginina';

  @override
  String get supplement_whey_protein => 'Whey protein';

  @override
  String get supplement_casein => 'Caseína';

  @override
  String get supplement_vegan_protein => 'Proteína vegana';

  @override
  String get supplement_omega3 => 'Ômega-3';

  @override
  String get supplement_fish_oil => 'Óleo de peixe';

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
