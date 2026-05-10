package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class TraumMedicationWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_medication).apply {
                setTextViewText(
                    R.id.meds_progress,
                    "${widgetData.getString("medsTaken", "0")} / ${widgetData.getString("medsTotal", "0")}"
                )
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
