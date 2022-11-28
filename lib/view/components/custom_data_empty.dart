import 'package:flutter/material.dart';
class DataEmptyWidget extends StatelessWidget {
  const DataEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      const Center(
      child: Text("No data Found",
          style: TextStyle(
              color: Colors.white)),
    );
  }
}