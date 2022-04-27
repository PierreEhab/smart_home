import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedInkwell extends StatelessWidget {
  const RoundedInkwell({Key? key,required this.onTap,required this.child,required this.text,this.color}) : super(key: key);
  final VoidCallback onTap;
  final Widget child;
  final String text;
  final Color ? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: MediaQuery.of(context).size.width * 0.15,
              child: child,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
