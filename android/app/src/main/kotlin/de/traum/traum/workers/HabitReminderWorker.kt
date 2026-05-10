package de.traum.traum.workers

import android.content.Context
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.work.Worker
import androidx.work.WorkerParameters
import de.traum.traum.R

class HabitReminderWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val notification = NotificationCompat.Builder(applicationContext, "habit_reminders")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Gewohnheiten checken")
            .setContentText("Hast du heute alle Gewohnheiten erledigt?")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)
            .build()
        NotificationManagerCompat.from(applicationContext)
            .notify(System.currentTimeMillis().toInt(), notification)
        return Result.success()
    }
}
