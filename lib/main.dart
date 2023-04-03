import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'color_schemes.dart';
import 'screens/screens.dart';
import 'states_provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider<StateProvider>(
      create: (context) => StateProvider()
        ..initializeTheme()
        ..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StateProvider>();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: state.isDarkMode
            ? const Color(0xFF201A19)
            : const Color(0xFFFFFBFF),
        systemNavigationBarIconBrightness:
            state.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Timiente',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        cardColor: Colors.black26,
      ),
      themeMode: state.themeMode,
      home: const SplashScreen(nextRouteName: "/home"),
      routes: {
        "/home": (ctx) => const HomeScreen(),
        "/create": (ctx) => const CreateTask(),
        "/task": (ctx) => const TaskDetails()
      },
    );
  }
}
