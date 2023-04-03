import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../states_provider.dart';
import 'responsive.dart';
import 'search_bar.dart';

class CustomAppBar extends StatelessWidget {
  final bool showSearchbar;
  final void Function(String) onTextChange;
  const CustomAppBar({
    super.key,
    required this.onTextChange,
    required this.showSearchbar,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<StateProvider>().isDarkMode;

    void onPressed() async {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor:
              isDarkMode ? const Color(0xFFFFFBFF) : const Color(0xFF201A19),
          systemNavigationBarIconBrightness:
              isDarkMode ? Brightness.dark : Brightness.light,
        ),
      );
      await Provider.of<StateProvider>(context, listen: false).changeTheme();
    }

    return AppBar(
      title: Text("Timiente", style: Theme.of(context).textTheme.titleLarge),
      actions: [
        if (!Responsive.isMobile(context))
          SizedBox(
            width: 300.0,
            child: SearchBar(
              hintText: "Search notes",
              borderRadius: 50,
              icon: Icons.search,
              onChanged: onTextChange,
            ),
          ),
        if (!Platform.isAndroid)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed("/create"),
          ),
        IconButton(
          icon: Icon(isDarkMode ? Icons.sunny : Icons.nightlight),
          onPressed: onPressed,
        ),
        const SizedBox(width: 8.0)
      ],
      leading: null,
      bottom: showSearchbar
          ? PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SearchBar(
                  hintText: "Search notes",
                  borderRadius: 50,
                  icon: Icons.search,
                  onChanged: onTextChange,
                ),
              ),
            )
          : null,
    );
  }
}
