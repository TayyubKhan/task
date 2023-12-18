import 'package:flutter/material.dart';
import 'package:task/View/Category2View.dart';
import 'package:task/View/Category1View1.dart';

import 'Category2View2.dart';

class AppTabBarView2 extends StatefulWidget {
  const AppTabBarView2({super.key});

  @override
  State<AppTabBarView2> createState() => _AppTabBarView2State();
}

class _AppTabBarView2State extends State<AppTabBarView2> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category 2'),
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
            Category2View(),
            Category2View2(),
          ],
        ),
      ),
    );
  }
}
