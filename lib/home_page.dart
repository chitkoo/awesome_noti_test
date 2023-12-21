import 'package:flutter/material.dart';

import 'notification_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    NotificationController().addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Firebase Token:',
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                NotificationController().firebaseToken,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Native Token:',
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                NotificationController().nativeToken,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Push the button to create a new local notification or reset the badge counter',
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: '2',
              onPressed: () => NotificationController.createNewNotification(),
              tooltip: 'Create New notification',
              child: const Icon(Icons.outgoing_mail),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              heroTag: '1',
              onPressed: () => NotificationController.resetBadge(),
              tooltip: 'Reset Badge',
              child: const Icon(Icons.exposure_zero),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              heroTag: '0',
              onPressed: () => NotificationController.deleteToken(),
              tooltip: 'Delete token',
              child: const Icon(Icons.recycling),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
