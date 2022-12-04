import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Permission.camera.request();
    super.initState();
  }

  final appFunction = [
    ['Color Camera', 'Help you see identify colors in your surrounding environment.', '/cam_color_picker'],
    ['Colorblind Test', 'Help you identify which type of colorblindness you have.', '/color_blind_test'],
    ['Colorblind Simulator', 'Know how people with colorblindness see.', '/colorblind_simulator'],
    ['Color Picker', 'Get colors from your photos', '/color_picker'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eyerizer'),
      ),
      body: ListView.builder(
        itemCount: appFunction.length,
        itemBuilder: (context, index) {
          final title = appFunction[index][0];
          final subtitle = appFunction[index][1];
          final route = appFunction[index][2];
          return ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
          );
        },
      ),
    );
  }
}
