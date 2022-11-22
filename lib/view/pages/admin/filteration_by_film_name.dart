import 'package:flutter/material.dart';
class FiltartionByFilmName extends StatefulWidget {
  const FiltartionByFilmName({Key? key}) : super(key: key);

  @override
  State<FiltartionByFilmName> createState() => _FiltartionByFilmNameState();
}

class _FiltartionByFilmNameState extends State<FiltartionByFilmName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filteration By Name"),
      ),
      body: Center(
        child: Text("Filteration By Name"),
      ),
    );
  }
}
