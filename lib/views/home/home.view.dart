import 'package:flutter/material.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/views/home/widget/menu.widget.dart';
import 'package:quizlet_xspin/views/home/widget/panel.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'Xspin Quizlet',
        body: Center(
          child: Column(
            children: [PanelWidget(), MenuWidget()],
          ),
        ));
  }
}
