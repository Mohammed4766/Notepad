import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'Pages/HomePage.dart';
import 'data.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Note(),
    child: DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: HomePage(),
    );
  }
}
