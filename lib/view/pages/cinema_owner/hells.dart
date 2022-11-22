import 'package:flutter/material.dart';
class HallsScreen extends StatefulWidget {
  const HallsScreen({Key? key}) : super(key: key);

  @override
  State<HallsScreen> createState() => _HallsScreenState();
}

class _HallsScreenState extends State<HallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hells Screen"),
      ),
      body: const Center(
        child: Text("Hells Screen"),
      ),
    );
  }
}
