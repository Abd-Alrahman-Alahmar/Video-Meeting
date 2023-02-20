import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_9/resources/auth_methods.dart';
import 'package:flutter_9/screens/sign_in_screen.dart';
import 'package:flutter_9/utils/colors.dart';
import 'package:flutter_9/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Text(
                'Start or join a meeting',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Image.asset(
                'assets/images/onboarding.jpg',
                scale: 1.5,
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.all(10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                      onPressed: ()  async {
                    bool res = await _authMethods.signInWithGoogle(context);
                    if (res) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  icon: Image.asset('assets/images/Google.png',scale: 55,),
                      label: const Text(
                        'Continue With Google',
                        style: TextStyle(
                fontSize: 17,
                color: buttonColor
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(350,50),
                        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
               // side: const BorderSide(color: buttonColor),
                        )
                      ),
                    ),
              ),
            ),
           
            Row(children: const <Widget>[
              Expanded(
                child: Divider(color: Colors.white, indent: 32,endIndent: 10,),
              ),
              Text("OR"),
              Expanded(
                child: Divider(color: Colors.white,indent: 10,endIndent: 32,),
              ),
            ]),
            
            CustomButton(
              text: 'Sign Up',
              onPressed: () =>
                  Navigator.pushNamed(
                    context, '/signup-email-password'),
              
              
            ),      
            
                RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                        color: Colors.white,
                        // fontSize: Diminsion.font20,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                context, EmailPasswordLogin.routeName),
                          text: " Login",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: buttonColor,
                            //fontSize: Diminsion.font20,),
                          ),
                        ),
                      ]),
                ),
              ],
            )        
        
      ),
    );
  }
}
