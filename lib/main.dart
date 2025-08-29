import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Colors Generator',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
