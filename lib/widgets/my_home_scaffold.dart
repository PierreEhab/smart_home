import 'package:flutter/material.dart';

class MyHomeScaffold extends StatefulWidget {
  const MyHomeScaffold({Key? key,required this.appBarTitle,required this.body,this.floatingActionButton}) : super(key: key);
  final String appBarTitle;
  final Widget body;
  final Widget ? floatingActionButton;
  @override
  State<MyHomeScaffold> createState() => _MyHomeScaffoldState();
}

class _MyHomeScaffoldState extends State<MyHomeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        centerTitle: true,
      ),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
