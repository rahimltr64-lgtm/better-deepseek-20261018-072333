import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// خدمة التذكير اليومي.
///
/// ملاحظة: يتم الجدولة على أساس UTC مع الحفاظ على الوقت المحلي المطلوب،
/// وهذا يعمل بشكل صحيح في المناطق التي لا تعتمد التوقيت الصيفي.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const int _dailyId = 1001;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _available = false;

  /// هل الإشعارات مدعومة ومهيأة على هذا الجهاز؟
  bool get isAvailable => _available;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      tzdata.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('UTC'));

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(settings);
      _available = true;
    } catch (error) {
      debugPrint('NotificationService init failed: $error');
      _available = false;
    }
  }

  NotificationDetails _details() {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'daily_learning',
      'تذكير التعلّم اليومي',
      channelDescription: 'تذكير لطيف بجلسة تعلّم قصيرة للطفل',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails ios = DarwinNotificationDetails();

    return const NotificationDetails(android: android, iOS: ios);
  }

  /// طلب إذن الإشعارات من المستخدم.
  Future<bool> requestPermissions() async {
    await init();
    if (!_available) return false;

    try {
      final AndroidFlutterLocalNotificationsPlugin? android =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        final bool? granted = await android.requestNotificationsPermission();
        return granted ?? false;
      }

      final IOSFlutterLocalNotificationsPlugin? ios =
          _plugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (ios != null) {
        final bool? granted = await ios.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    } catch (error) {
      debugPrint('requestPermissions error: $error');
    }
    return false;
  }

  /// إظهار إشعار فوري (للتجربة).
  Future<void> showTestNotification() async {
    await init();
    if (!_available) return;
    try {
      await _plugin.show(
        0,
        'مرحباً 👋',
        'هذا إشعار تجريبي من تطبيق تعلّم معي.',
        _details(),
      );
    } catch (error) {
      debugPrint('showTestNotification error: $error');
    }
  }

  /// جدولة تذكير يومي متكرر في الساعة المحددة.
  Future<bool> scheduleDailyReminder({
    required int hour,
    required int minute,
  }) async {
    await init();
    if (!_available) return false;

    try {
      await cancelDailyReminder();

      final DateTime now = DateTime.now();
      DateTime target = DateTime(now.year, now.month, now.day, hour, minute);
      if (!target.isAfter(now)) {
        target = target.add(const Duration(days: 1));
      }

      final tz.TZDateTime scheduled =
          tz.TZDateTime.from(target.toUtc(), tz.UTC);

      await _plugin.zonedSchedule(
        _dailyId,
        'حان وقت التعلّم 🌟',
        'خمس دقائق فقط لنتعلّم حرفاً أو رقماً جديداً معاً!',
        scheduled,
        _details(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'daily_reminder',
      );
      return true;
    } catch (error) {
      debugPrint('scheduleDailyReminder error: $error');
      return false;
    }
  }

  Future<void> cancelDailyReminder() async {
    if (!_available) return;
    try {
      await _plugin.cancel(_dailyId);
    } catch (error) {
      debugPrint('cancelDailyReminder error: $error');
    }
  }
}
