
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final getstorage = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Add center point
            end: Alignment.center,
            colors: [
              Color(0xFF6EDB7B), // Green// Light green
              Color(0xFFCBFF6B), // Yellow-green
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 100, // Aligns the image at the top
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/splogo.png', // Replace with your image asset path
                  height: 200,
                  width: 200,
                  alignment: Alignment.topCenter, // Centers the image horizontally
                ),
              ),
            ),
            Positioned(
              top: 30, // Adjust the positioning of the back icon as needed
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

        Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child:
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Poppins_sego',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter your email for verification process \nwe will send you 4 digits code to your email.',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Regular',
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Phone/Email',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  fontFamily: 'Poppins_sego',
                                  color: Colors.black,
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Your Phone / Email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins_sego',
                                  ),
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
                                // Add your click functionality here
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins_sego',
                                  fontSize: 18.0,
                                ),
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
          ],
        ),
      ),
    );
  }

}

