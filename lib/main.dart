import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'noti_page.dart';
import 'notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationController.initializeLocalNotifications(debug: true);
  await NotificationController.initializeRemoteNotifications(debug: true);
  await NotificationController.initializeIsolateReceivePort();
  await NotificationController.getInitialNotificationAction();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: "basic_channel",
  //       channelName: "Basic Notification",
  //       channelDescription: "Basic Notification Channel",
  //       channelGroupKey: "basic_channel_group",
  //       playSound: true,
  //     ),
  //   ],
  //   channelGroups: [
  //     NotificationChannelGroup(
  //       channelGroupKey: "basic_channel_group",
  //       channelGroupName: "Basic Group",
  //     ),
  //   ],
  // );

  // bool isAllowedToSendNotification =
  //     await AwesomeNotifications().isNotificationAllowed();

  // debugPrint('Noti Allowed : $isAllowedToSendNotification');

  // if (!isAllowedToSendNotification) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  // }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  static const String routeHome = '/', routeNotification = '/notification-page';

  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    NotificationController.requestFirebaseToken();
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // AwesomeNotifications().setListeners(
  //   //   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
  //   //   onNotificationCreatedMethod:
  //   //       NotificationController.onNotificationCreatedMethod,
  //   //   onNotificationDisplayedMethod:
  //   //       NotificationController.onNotificationDisplayedMethod,
  //   //   onDismissActionReceivedMethod:
  //   //       NotificationController.onDismissActionReceivedMethod,
  //   // );
  // }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    pageStack.add(MaterialPageRoute(
        builder: (_) =>
            const MyHomePage(title: 'Awesome Notifications FCM Example App')));
    if (initialRouteName == routeNotification &&
        NotificationController().initialAction != null) {
      pageStack.add(MaterialPageRoute(
          builder: (_) => NotificationPage(
              receivedAction: NotificationController().initialAction!)));
    }
    return pageStack;
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                title: 'Awesome Notifications FCM Example App'));

      case routeNotification:
        ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return MaterialPageRoute(
            builder: (_) => NotificationPage(receivedAction: receivedAction));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notifications - Simple Example',
      navigatorKey: MyApp.navigatorKey,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
    // return MaterialApp(
    //   navigatorKey: MyApp.navigatorKey,
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   home: Scaffold(
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         AwesomeNotifications().createNotification(
    //           content: NotificationContent(
    //             id: 1,
    //             channelKey: "basic_channel",
    //             title: 'Awesome notification!',
    //             body: 'This is local notification!',
    //             wakeUpScreen: true,
    //           ),
    //         );
    //       },
    //       child: const Icon(Icons.notifications_active),
    //     ),
    //   ),
    // );
  }
}
