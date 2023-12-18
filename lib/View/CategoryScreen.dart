import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task/View/AppTabBarView.dart';
import 'package:task/View/AppTabBarView2.dart';
import 'package:task/View/Category2View.dart';

import 'Category1View1.dart';

class CateogryScreen extends StatefulWidget {
  const CateogryScreen({super.key});

  @override
  State<CateogryScreen> createState() => _CateogryScreenState();
}

class _CateogryScreenState extends State<CateogryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          container('Category 1', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AppTabBarView()));
          }),
          const Gap(50),
          container('Category 2', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AppTabBarView2()));
          }),
        ],
      ),
    );
  }

  container(String title, VoidCallback onTap) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
