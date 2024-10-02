import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("a yefrid le gustan los hombres"),
      ),
      body: Center(
        child: Container(
          child: Text("LE FULETEAN EL TANQUE", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
