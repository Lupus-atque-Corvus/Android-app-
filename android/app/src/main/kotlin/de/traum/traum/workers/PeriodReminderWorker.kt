package de.traum.traum.workers

import android.content.Context
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.work.Worker
import androidx.work.WorkerParameters
import de.traum.traum.R

class PeriodReminderWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val days = inputData.getInt("daysUntil", 3)
        val notification = NotificationCompat.Builder(applicationContext, "period_reminders")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Periode in $days Tagen")
            .setContentText("Deine nächste Periode wird in $days Tagen erwartet.")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)
            .build()
        NotificationManagerCompat.from(applicationContext)
            .notify(System.currentTimeMillis().toInt(), notification)
        return Result.success()
    }
}
