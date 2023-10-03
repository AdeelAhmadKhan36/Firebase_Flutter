import 'package:flutter/material.dart';

class Messaging extends StatefulWidget {
 final String Id;
   Messaging({super.key,required this.Id});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging Screen'  +widget.Id),
        centerTitle: true,

      ),
    );
  }
}
