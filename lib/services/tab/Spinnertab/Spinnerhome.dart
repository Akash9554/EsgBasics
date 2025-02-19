import 'package:flutter/material.dart';
import 'CreateFormForTextileManufacturerbatch.dart';
import 'GetSpinnerIncommingCottonbatch.dart';
import 'TextileManufacturerInvoiceForbatch.dart';


class SpinnerHome extends StatefulWidget {
  const SpinnerHome({super.key});

  @override
  _SpinnerHomeState createState() => _SpinnerHomeState();
}

class _SpinnerHomeState extends State<SpinnerHome> {
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
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/splogo.png', // Replace with your image asset path
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 400,
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
                              MaterialPageRoute(builder: (context) => const GetSpinnerIncommingCottonbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Incoming Yarn Batch',
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
                              MaterialPageRoute(builder: (context) => const CreateFormForTextileManufacturerbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Create Form For Textile manufacturer',
                            textAlign: TextAlign.center,
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
                              MaterialPageRoute(builder: (context) => const TextileManufacturerInvoiceForbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Textile manufacturer Invoice List',
                            textAlign: TextAlign.center,
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
