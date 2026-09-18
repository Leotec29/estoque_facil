import 'package:flutter/material.dart';

import 'app/router.dart';

void main() {
  runApp(const EstoqueFacilApp());
}

class EstoqueFacilApp extends StatelessWidget {
  const EstoqueFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Estoque Fácil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
