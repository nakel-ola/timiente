import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'color_schemes.dart';
import 'screens/screens.dart';
import 'states_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider<StateProvider>(
      create: (context) => StateProvider()
        ..initializeTheme()
        ..initializeTasks(),
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
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
        fontFamily: "Rubik",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        cardColor: Colors.black26,
        fontFamily: "Rubik",
      ),
      themeMode: state.themeMode,
      initialRoute: "/",
      routes: {
        "/": (ctx) => const HomeScreen(),
        "/create": (ctx) => const CreateTask(),
        "/task": (ctx) => const TaskDetails()
      },
    );
  }
}
