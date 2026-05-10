package de.traum.traum.workers

import android.content.Context
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.work.Worker
import androidx.work.WorkerParameters
import de.traum.traum.R

class BudgetAlertWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val percent = inputData.getInt("percent", 90)
        val notification = NotificationCompat.Builder(applicationContext, "budget_alerts")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Budget-Warnung")
            .setContentText("Du hast $percent % deines Monatsbudgets verbraucht.")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()
        NotificationManagerCompat.from(applicationContext)
            .notify(System.currentTimeMillis().toInt(), notification)
        return Result.success()
    }
}
