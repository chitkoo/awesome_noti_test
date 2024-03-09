import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic Notification Channel",
        channelGroupKey: "basic_channel_group",
        playSound: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      ),
    ],
  );

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  debugPrint('Noti Allowed : $isAllowedToSendNotification');

  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter testing srctree',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 1,
                channelKey: "basic_channel",
                title: 'Awesome notification!',
                body: 'This is local notification!',
                wakeUpScreen: true,
              ),
            );
          },
          child: const Icon(Icons.notifications_active),
        ),
      ),
    );
  }
}
