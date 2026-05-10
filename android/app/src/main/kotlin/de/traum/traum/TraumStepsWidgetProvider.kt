package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class TraumStepsWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.os.Bundle
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val steps = widgetData.getString("steps", "0").toIntOrNull() ?: 0
            val stepsGoal = widgetData.getString("stepsGoal", "10000").toIntOrNull() ?: 10000
            val progress = if (stepsGoal > 0) (steps * 100 / stepsGoal).coerceIn(0, 100) else 0

            val views = RemoteViews(context.packageName, R.layout.widget_steps).apply {
                setTextViewText(R.id.steps_count, steps.toString())
                setTextViewText(R.id.steps_goal_label, "/ $stepsGoal Schritte")
                setProgressBar(R.id.steps_progress, 100, progress, false)
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
