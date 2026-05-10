package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class TraumBudgetWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.os.Bundle
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val budgetSpent = widgetData.getString("budgetSpent", "0.00")
            val budgetLimit = widgetData.getString("budgetLimit", "0.00")
            val spent = budgetSpent.toDoubleOrNull() ?: 0.0
            val limit = budgetLimit.toDoubleOrNull() ?: 0.0
            val progress = if (limit > 0.0) ((spent / limit) * 100).toInt().coerceIn(0, 100) else 0

            val views = RemoteViews(context.packageName, R.layout.widget_budget).apply {
                setTextViewText(R.id.budget_spent, "$budgetSpent €")
                setTextViewText(R.id.budget_limit, "von $budgetLimit €")
                setProgressBar(R.id.budget_progress, 100, progress, false)
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
