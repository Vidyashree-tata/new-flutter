import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
final String title;
final Color color;
final VoidCallback onPress;
  const MyButton({Key? key,required this.title,this.color=Colors.blue,required this.onPress}) : super(key: key); // Updated constructor

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: InkWell(
            onTap: onPress,
            child: Container(
                  height: 80,
                  decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
                  ),
                  child: Center(
            child: Text(title,style: TextStyle(color: Colors.white),),

                  ),
                ),
          ),

        )

    );


  }
}