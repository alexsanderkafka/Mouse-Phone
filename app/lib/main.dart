import 'package:flutter/material.dart';
import 'package:mouse_phone/routes/bottom_navigation.dart';
import 'package:mouse_phone/store/connection_data.dart';
import 'package:provider/provider.dart';

void main() {
  final ConnectionData connectionData = ConnectionData();
  runApp(
    Provider<ConnectionData>.value(value: connectionData, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BottomNavigation(),
    );
  }
}
