package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class TraumHabitsWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_habits).apply {
                setTextViewText(
                    R.id.habits_progress,
                    "${widgetData.getString("habitsCompleted", "0")} / ${widgetData.getString("habitsTotal", "0")}"
                )
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
