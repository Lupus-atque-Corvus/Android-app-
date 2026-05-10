package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class TraumAbstinenceWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_abstinence).apply {
                setTextViewText(R.id.abstinence_title, widgetData.getString("abstinenceTitle", "Abstinenz"))
                setTextViewText(R.id.abstinence_duration, widgetData.getString("abstinenceDuration", "—"))
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
