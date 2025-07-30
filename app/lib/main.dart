import 'package:flutter/material.dart';
import 'package:mouse_phone/navigation/bottom_navigation.dart';
import 'package:mouse_phone/model_view/connection_model_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final ConnectionModelView connectionData = ConnectionModelView();
  runApp(
    Provider<ConnectionModelView>.value(
      value: connectionData,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mouse Phone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BottomNavigation(),
    );
  }
}
