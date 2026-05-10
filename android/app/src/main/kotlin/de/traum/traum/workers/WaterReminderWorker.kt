package de.traum.traum.workers

import android.content.Context
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.work.Worker
import androidx.work.WorkerParameters
import de.traum.traum.R

class WaterReminderWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val notification = NotificationCompat.Builder(applicationContext, "water_reminders")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Wasser trinken")
            .setContentText("Zeit für ein Glas Wasser – bleib hydratisiert!")
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setAutoCancel(true)
            .build()
        NotificationManagerCompat.from(applicationContext)
            .notify(System.currentTimeMillis().toInt(), notification)
        return Result.success()
    }
}
