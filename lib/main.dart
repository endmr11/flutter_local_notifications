import 'package:flutter/material.dart';
import 'package:flutter_local_push_notification/notification_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.indigo.shade900),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.indigo.shade900)),
      home: const MyHomePage(title: 'Bildirim'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotificationService _notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Basit Bildirim'),
                onPressed: () async {
                  await _notificationService.showNotifications("A");
                },
              ),
              const SizedBox(height: 3),
              ElevatedButton(
                child: const Text('Planlı Bildirim'),
                onPressed: () async {
                  await _notificationService.scheduleNotifications("B");
                },
              ),
              const SizedBox(height: 3),
              ElevatedButton(
                child: const Text('Bildirim İptal'),
                onPressed: () async {
                  await _notificationService.cancelNotifications(0);
                },
              ),
              const SizedBox(height: 3),
              ElevatedButton(
                child: const Text('Tüm Bildirimler İptal'),
                onPressed: () async {
                  await _notificationService.cancelAllNotifications();
                },
              ),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
