package de.traum.traum.workers

import android.content.Context
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.work.Worker
import androidx.work.WorkerParameters
import de.traum.traum.R

class TodoDueTodayWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val count = inputData.getInt("count", 0)
        if (count == 0) return Result.success()
        val notification = NotificationCompat.Builder(applicationContext, "todo_reminders")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Aufgaben heute fällig")
            .setContentText("Du hast $count Aufgabe(n) für heute.")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()
        NotificationManagerCompat.from(applicationContext)
            .notify(System.currentTimeMillis().toInt(), notification)
        return Result.success()
    }
}
