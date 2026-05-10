package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class TraumHealthWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_health).apply {
                setTextViewText(R.id.sleep_value, "${widgetData.getString("sleepHours", "0")}h")
                setTextViewText(R.id.hr_value, "${widgetData.getString("heartRate", "—")} bpm")
                setTextViewText(R.id.mood_value, widgetData.getString("mood", "—"))
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
