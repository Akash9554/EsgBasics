
import 'package:esgbasics/services/tab/GarmentMAnufascturer/Textiletab2.dart';
import 'package:esgbasics/services/tab/GinnerTab/Ginnertab.dart';
import 'package:esgbasics/services/tab/Spinnertab/Spinnertab.dart';
import 'package:esgbasics/services/tab/Textiletab/Textiletab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Hometab.dart';
import 'services/tab/GinnerTab/Ginnerhome.dart';


class OTPScreen extends StatefulWidget {
  String otp;
  OTPScreen({Key? key,required this.otp}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int? userid=0;
  String email="";
  List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
  @override
  initState() {
    super.initState();
    userid=GetStorage().read("id");
    email=GetStorage().read("email");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFF6EDB7B), // Green
              Color(0xFFCBFF6B), // Yellow-green
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 60.0, 5.0, 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/splogo.png',
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                    Text(
                      'Code Verification'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 9, 9, 9),
                        fontFamily: "Poppins_sego",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Enter the code we just sent to'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 9, 9, 9),
                        fontFamily: "Poppins_sego",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 9, 9, 9),
                        fontFamily: "Poppins_sego",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                            (index) => Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: TextField(
                            controller: otpControllers[index],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              counterText: "",
                              hintText: '-',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
              Text(
                'Enter 1234 right now'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 9, 9, 9),
                  fontFamily: "Poppins_sego",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: submitOTP,
                        child: Text(
                          'Submit'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins_sego",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive Verification code?".tr,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 9, 9, 9),
                            fontFamily: "Poppins_sego",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: resendOTP,
                          child: Text(
                            'Resend Verification code'.tr,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 9, 9, 9),
                              fontFamily: "Poppins_sego",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "Please check your inbox and spam folder".tr,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 9, 9, 9),
                            fontFamily: "Poppins_sego",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }





  void submitOTP() {
    EasyLoading.show(status: 'loading...');
    String enteredOTP = otpControllers.map((controller) => controller.text).join();
    if(enteredOTP=="1234"){
      EasyLoading.dismiss();
      if(GetStorage().read("user_type")=="1"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  HomeTab()));
      }else if(GetStorage().read("user_type")=="2"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  GinnerTab()));
      }else if(GetStorage().read("user_type")=="3"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  Spinnertab()));
      }else if(GetStorage().read("user_type")=="4"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  Textiletab()));
      }else if(GetStorage().read("user_type")=="5"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  Textiletab2()));
      }
    }else{
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: "Failed Verification Code is not Correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
  }

  void resendOTP() {
   /* LoginController.resendotp(
        context,userid
    );*/
  }
}
