import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task/View/Cat1Screen2.dart';
import 'package:task/View/Category1View1.dart';

class AppTabBarView extends StatefulWidget {
  const AppTabBarView({super.key});

  @override
  State<AppTabBarView> createState() => _AppTabBarViewState();
}

class _AppTabBarViewState extends State<AppTabBarView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category 1'),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Category1View1(),
            Cat1Screen2(),
          ],
        ),
      ),
    );
  }
}
