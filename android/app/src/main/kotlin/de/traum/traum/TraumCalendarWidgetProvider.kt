package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class TraumCalendarWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.os.Bundle
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_calendar).apply {
                setTextViewText(R.id.appointment_text, widgetData.getString("nextAppointment", "Kein Termin"))
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
