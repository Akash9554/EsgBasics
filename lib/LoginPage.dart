
import 'package:esgbasics/services/SignupType/SigninPageGarment.dart';
import 'package:esgbasics/services/SignupType/SigninPageGinner.dart';
import 'package:esgbasics/services/SignupType/SigninPageSpinner.dart';
import 'package:esgbasics/services/SignupType/SigninPageTexttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'ForgotPassword.dart';
import 'services/SignupType/SigninPage.dart';
import 'controller/login_controller.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final getstorage = GetStorage();
  String emailError = 'Please enter email';
  String passwordError = 'Please enter password';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: sheight, // Ensure the content height is at least as tall as the screen
          ),
          child: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Color(0xFF6EDB7B), // Green// Light green
                    Color(0xFFCBFF6B), // Yellow-green
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Add padding to ensure content is not cut off
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    'assets/images/splogo.png',
                    width: 150.0,
                    height: 150.0,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '    Phone/Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: 'Poppins_sego',
                              color: Colors.black,
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Your Phone / Number',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0, fontFamily: 'Poppins_sego'),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.person, color: Colors.grey), // Add prefix icon user
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '   Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: 'Poppins_sego',
                              color: Colors.black,
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Your Password',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0, fontFamily: 'Poppins_sego'),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.lock, color: Colors.grey), // Add prefix lock icon
                              suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey), // Add suffix eye icon
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add other form fields similarly
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              signin(context);
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins_semi',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the children to the start and end of the row
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showUserTypeDialog(context);

                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Poppins_sego',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the sign in page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPassword()),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Poppins_sego',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUserTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select User Type',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Poppins_sego'
            ),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildUserTypeButton(context, 'Farmer'),
              _buildUserTypeButton(context, 'Ginner'),
              _buildUserTypeButton(context, 'Spinner'),
              _buildUserTypeButton(context, 'Textile Manufacturer'),
              _buildUserTypeButton(context, 'Garment Manufacturer'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserTypeButton(BuildContext context, String userType) {
    return  Padding(
        padding: const EdgeInsets.all(10.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Container(
        width: 400.0,
        height: 60.0,
        decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.0),
    ),
    child:TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _performAction(userType);
      },
      child: Text(
        userType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'Poppins_semi',
        ),
      ),
    ),),],
    ),
    );
  }

  void _performAction(String userType) {
    if(userType=="Farmer"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }else if(userType=="Ginner"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPageGinner()),
      );
    }else if(userType=="Spinner"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPageSpinner()),
      );
    }else if(userType=="Textile Manufacturer"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPageTextile()),
      );
    }else if(userType=="Garment Manufacturer"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SigninPageGarment()),
      );
    }
  }


  void signin(BuildContext context) {

    if(emailController.text.trim()==""){
      EasyLoading.showError(emailError);
    }else if(passwordController.text.trim().isEmpty){
      EasyLoading.showError(passwordError);
    }else {
      LoginController.login(
        context,
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }


}

