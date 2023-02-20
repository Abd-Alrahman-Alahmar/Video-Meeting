import 'package:flutter/material.dart';
import 'package:flutter_9/utils/colors.dart';

class HomeMeetingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color? color;
  HomeMeetingButton({ Key? key,
  required this.onPressed,
  required this.icon,
  required this.text,
   this.color}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color==null ? buttonColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 4),
                )
              ]
            ),
            width: 60,
            height: 60,
            child:Icon(icon,color:color==null ? Colors.white : buttonColor,size: 30,) ,
          ),
          const SizedBox(height: 10,),
          Text(text, style: const TextStyle(color: Colors.grey),)
        ],
      ),
      
    );
  }
}