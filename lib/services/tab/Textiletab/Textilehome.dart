
import 'package:flutter/material.dart';

import '../Spinnertab/TextileManufacturerInvoiceForbatch.dart';
import 'CreateFormForGarmentbatch.dart';
import 'GarmentInvoiceForbatch.dart';
import 'GetTextileIncommingCottonbatch.dart';





class Textilehome extends StatefulWidget {
  const Textilehome({super.key});

  @override
  _TextilehomeState createState() => _TextilehomeState();
}

class _TextilehomeState extends State<Textilehome> {
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
                  height: 200,
                  width: 200,
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
                              MaterialPageRoute(builder: (context) => const GetTextileIncommingCottonbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Incoming Batch',
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
                              MaterialPageRoute(builder: (context) => const CreateFormForGarmentbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Create Form For Garment manufacturer',
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
                              MaterialPageRoute(builder: (context) => const GarmentInvoiceForbatch()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Garment manufacturer Invoice List',
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
