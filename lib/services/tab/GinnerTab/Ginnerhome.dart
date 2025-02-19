import 'package:flutter/material.dart';

import 'CreateFormForSpinnerCottonbatch.dart';
import 'GetIncommingCottonbatch.dart';
import 'SpinnerInvoiceForGinnerCottonbatch.dart';

class GinnerHome extends StatefulWidget {
  const GinnerHome({super.key});

  @override
  _GinnerHomeState createState() => _GinnerHomeState();
}

class _GinnerHomeState extends State<GinnerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF), // Green
              Color(0xFF79DD8B), // Light green
              Color(0xFFCBFF6B), // Yellow-green
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/splogo.png', // Replace with your image asset path
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const GetIncommingCottonbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Incoming Cotton Batch',
                            style: TextStyle(
                              fontFamily: 'Poppins_medium',
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CreateFormForSpinnerCottonbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Create Form For Spinner',
                            style: TextStyle(
                              fontFamily: 'Poppins_medium',
                              color: Colors.white,
                              fontSize: 14.0,

                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SpinnerInvoiceForGinnerCottonbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Spinner Invoice List',
                            style: TextStyle(
                              fontFamily: 'Poppins_medium',
                              color: Colors.white,
                              fontSize: 14.0,

                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
