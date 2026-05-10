package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class TraumNutritionWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.os.Bundle
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_nutrition).apply {
                setTextViewText(R.id.kcal_value, widgetData.getString("kcal", "0"))
                setTextViewText(R.id.protein_value, "${widgetData.getString("protein", "0")} g")
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
