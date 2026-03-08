# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# ML Kit
-keep class com.google.mlkit.** { *; }
-keep class com.google_mlkit_** { *; }
-dontwarn com.google.mlkit.**

# Drift / SQLite
-keep class androidx.sqlite.** { *; }
-keep class com.google.crypto.tink.** { *; }

# Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Play Core
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }