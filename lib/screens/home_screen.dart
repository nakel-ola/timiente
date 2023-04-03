import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../states_provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchText = "";
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = context.watch<StateProvider>().tasks(_searchText);

    final bool showSearchbar = tasks.isNotEmpty && Responsive.isMobile(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          showSearchbar ? 120.0 : 50.0,
        ),
        child: CustomAppBar(
          showSearchbar: showSearchbar,
          onTextChange: (text) {
            setState(() {
              _searchText = text;
            });
          },
        ),
      ),
      body: TaskList(
        tasks: tasks,
        searchText: _searchText,
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed("/create"),
              tooltip: 'Create a new task',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
