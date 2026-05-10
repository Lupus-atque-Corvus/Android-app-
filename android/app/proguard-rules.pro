# Drift / SQLite
-keep class org.sqlite.** { *; }
-keep class org.sqlite.database.** { *; }

# Riverpod
-keep class dev.rvpod.** { *; }

# Flutter local notifications
-keep class com.dexterous.** { *; }

# WorkManager
-keep class androidx.work.** { *; }

# Kotlin coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepclassmembers class kotlinx.coroutines.** { volatile <fields>; }

# Generic Flutter keep
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# Health Connect
-keep class androidx.health.** { *; }
