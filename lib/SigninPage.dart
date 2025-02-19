
import 'dart:io';


import 'package:esgbasics/services/InformationPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'LoginPage.dart';
import 'Widget/PdfViewerPage.dart';
import 'controller/SignUpControler.dart';



class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final getstorage = GetStorage();
  String nameError = 'Please enter name';
  String numberError = 'Please enter number';
  String typeError = 'Please select your type';
  String emailError = 'Please enter email';
  String passwordError = 'Please enter password';
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int? _savedValue=6;
  String? _selectedValue;
  final List<Map<String, dynamic>> _items = [
    {'label': 'Farmer', 'value': 1},
    {'label': 'Ginner', 'value': 2},
    {'label': 'Spinner', 'value': 3},
    {'label': 'Textile Manufacturer', 'value': 4},
    {'label': 'Garment Manufacturer', 'value': 5},
  ];
  bool _isChecked = false;
  Future<void> openPdf(BuildContext context) async {
    try {
      File pdfFile = await getPdfFileFromAsset('assets/Ethical.pdf');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(pdfPath: pdfFile.path),
        ),
      );
    } catch (e) {
      print("Error opening PDF file: $e");
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // Add center point
              end: Alignment.center,
              colors: [
                Color(0xFF6EDB7B), // Green// Light green
                Color(0xFFCBFF6B), // Yellow-green
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),

              Text(
                'CREATE YOUR ACCOUNT',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Poppins_sego'
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Poppins_sego',
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Your Name',
                            hintStyle: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Contact No',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Poppins_sego',
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: numberController,
                          decoration: InputDecoration(
                            hintText: 'Your Contact Number',
                            hintStyle: TextStyle(color: Colors.black,fontSize: 16.0, fontFamily: 'Poppins_sego',),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Email address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Poppins_sego',
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Your Enter Email Address ',
                            hintStyle: TextStyle(color: Colors.black,fontSize: 16.0, fontFamily: 'Poppins_sego',),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
            padding: EdgeInsets.all(20.0),
            child:Container(
            width: double.infinity, // Make the container full width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: 'Poppins_sego',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child:
                    DropdownButtonHideUnderline(
                      child: SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownButton<String>(
                            hint: Text('Select an option'),
                            value: _selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValue = newValue;
                                _savedValue = _items
                                    .firstWhere((item) => item['label'] == newValue)['value'];
                              });
                            },
                            items: _items.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['label'],
                                child: Text(item['label']),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )

                  )

                ],
              ),
            ),
          ),),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Poppins_sego',
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black,fontSize: 16.0, fontFamily: 'Poppins_sego',),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Add other form fields similarly
              Padding(
                padding: EdgeInsets.all(20.0),
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
                        child: Text(
                          'Continue',
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
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _isChecked,
                    activeColor:Colors.black,
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      _showSubscriptionDialog(context);

                    },
                    child: Text(
                      'I accept the terms and conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Poppins_semi',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'If you already have an account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Poppins_semi',
                ),
              ),
              SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Navigate to the sign in page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Poppins_semi',
                ),
              ),),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onLastPageAccepted() {
    setState(() {
      _isChecked = true!;
      signin(context);
    });
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splogo.png',
                    width: 60.0,
                    height: 60.0,
                  ),
                  SizedBox(height: 16.0),
                    Text(
                      'Introduction to Compliance Questions and Guidelines for all ESG Supply Chain Employees for Certification',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: "open",
                      ),
                    ),
                  Text(
                    'Guild Employees Must Lead Rather than Follow.\n\n'
                        'The Ethical Standards Guild aims to include ESG employees who surpass national and international labor laws, setting new benchmarks for ethical conduct. Their mission is to act as leaders and models, creating standards shaped by cotton farmers, their employees, families, and the local community, rather than merely complying with the minimum requirements defined by existing laws.\n\n'
                        'The goal should always be to provide the highest possible protection to farmers, workers, and the environment. In regions lacking effective governance or enforcement of national and international laws, people often remain unprotected. The Guild’s standards, crafted with input from those directly affected—cotton farmers, their employees, families, and local communities—are fundamental and essential.\n\n'
                        '"Leading the way to an industry that values human dignity above all else."',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Open Sans",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: ElevatedButton(
                      onPressed: () {

                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InformationPages(onAccept: _onLastPageAccepted)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFF6EDB7B), backgroundColor: Color(0xFF6EDB7B), // Set onPrimary color to transparent
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Terms and Condition',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "open",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void signin(BuildContext context) {
    if(nameController.text.trim().isEmpty){
      EasyLoading.showError(nameError);
    }else if(numberController.text.trim().isEmpty){
      EasyLoading.showError(numberError);
    }else if(emailController.text.trim().isEmpty){
      EasyLoading.showError(emailError);
    }else if(_savedValue==6){
      EasyLoading.showError(typeError);

    }else if(passwordController.text.trim().isEmpty){
      EasyLoading.showError(passwordError);
    }else if(!_isChecked){
      _showSubscriptionDialog(context);
    }else {
      SignUpControler.login(
        context,
        nameController.text.trim(),
        numberController.text.trim(),
        emailController.text.trim(),

        passwordController.text.trim(),
          _savedValue.toString()
      );
    }
  }


}

