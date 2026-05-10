package de.traum.traum

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class TraumTodoWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_todo).apply {
                setTextViewText(R.id.todo_text, widgetData.getString("nextTodo", "Keine offenen Aufgaben"))
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
