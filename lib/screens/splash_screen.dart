import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states_provider.dart';

class SplashScreen extends StatefulWidget {
  final String nextRouteName;
  const SplashScreen({super.key, required this.nextRouteName});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacementNamed(widget.nextRouteName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<StateProvider>().isDarkMode;

    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt, size: 45.0),
                const SizedBox(width: 8.0),
                TextLiquidFill(
                  text: 'Timiente',
                  waveColor: isDarkMode ? Colors.white : Colors.black,
                  boxBackgroundColor: Theme.of(context).colorScheme.background,
                  textStyle: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  boxHeight: 100.0,
                  boxWidth: 170.0,
                )
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Created by Olamilekan", style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}
