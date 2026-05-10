package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class TraumOverviewWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.os.Bundle
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_overview).apply {
                setTextViewText(R.id.steps_value, widgetData.getString("steps", "0"))
                setTextViewText(R.id.water_value, "${widgetData.getString("waterMl", "0")} ml")
                setTextViewText(R.id.kcal_value, widgetData.getString("kcal", "0"))
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
