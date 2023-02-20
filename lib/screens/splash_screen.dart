import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
        
        children: [
          
          Image.asset(
            'assets/images/meet_logo.png',
            scale: 3,
          ),
          SizedBox(height: 15,),
          Text(
            'Nomo   ',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color:Colors.white,),
          ),
        ]),
      ),
    );
  }
}
