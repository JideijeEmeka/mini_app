import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/business_provider.dart';
import 'screens/business_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BusinessProvider())],
      child: MaterialApp(
        title: 'Business Directory',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const BusinessListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
