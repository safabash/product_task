import 'package:flutter/material.dart';
import 'package:product_task/controller/home/home_controller.dart';
import 'package:product_task/controller/single_product/single_product_controller.dart';
import 'package:product_task/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
    ChangeNotifierProvider<SingleProductController>(
        create: (_) => SingleProductController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
