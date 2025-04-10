import 'package:flutter/material.dart';
import 'package:loficafe/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:loficafe/provider/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // A widget which will be started on application startup
      home: const HomePage(),
    );
  }
}
