abstract class Routes {
  static const onboarding = '/onboarding';
  static const home = '/home';

  // Training
  static const training = '/training';
  static const activeWorkout = '/training/active';
  static const exerciseLibrary = '/training/exercises';
  static const workoutDetail = '/training/session/:id';
  static const exerciseProgress = '/training/exercise/:id/progress';

  // Health
  static const health = '/health';

  // Nutrition
  static const nutrition = '/nutrition';
  static const mealLog = '/nutrition/log';
  static const foodSearch = '/nutrition/search';
  static const shoppingList = '/nutrition/shopping';

  // Supplements
  static const supplements = '/supplements';

  // Planning
  static const planning = '/planning';
  static const calendar = '/planning/calendar';
  static const todos = '/planning/todos';
  static const goals = '/planning/goals';
  static const habits = '/planning/habits';

  // Medication
  static const medication = '/medication';

  // Abstinence
  static const abstinence = '/abstinence';

  // Budget
  static const budget = '/budget';
  static const transactionList = '/budget/transactions';
  static const addTransaction = '/budget/add';
  static const budgetStats = '/budget/stats';
  static const savings = '/budget/savings';

  // Period
  static const period = '/period';
  static const periodCalendar = '/period/calendar';
  static const cycleHistory = '/period/history';

  // Settings
  static const settings = '/settings';
  static const navSettings = '/settings/nav';
}
