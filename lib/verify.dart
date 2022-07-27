import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twilio_number_verification_ui/register.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({ Key? key, required this.phoneNumber }) : super(key: key);

  final String phoneNumber; 

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController controller = TextEditingController();

  String otp = '';

  bool isLoading = false;

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        children: [
          
          const SizedBox(height: 40,),

          SvgPicture.asset('assets/verify.svg', height: size.height / 2.5,),

          const SizedBox(height: 50,),

          const Center(
            child: Text(
              'OTP VERIFICATION',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.black
              ),
            ),
          ),

          const SizedBox(height: 20,),

          Center(
            child: Text.rich(
              TextSpan(
              text: "Enter the OTP sent to ",
                children: [
                  TextSpan(
                    text: '+' + widget.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  )
                ]
              )
            )
          ),

          const SizedBox(height: 30,),

          Form(
            child: PinCodeTextField(
              appContext: context,
              length: 4,
              cursorColor: Colors.black,
              enableActiveFill: true,
              controller: controller,
              keyboardType: TextInputType.number,

              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 60,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                activeColor: Colors.grey.shade200,
                inactiveColor: Colors.grey.shade200
              ),
            
              boxShadows: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  blurRadius: 1,
                  offset: Offset(2, 2,),
                )
              ],
              
              onCompleted: (v) {
                debugPrint("Completed");
              },

              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  otp = value;
                });
              },
            ),
          ),
            
          Center(
            child: Text(
              errorMessage, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
              )
            )
          ),
        
          const SizedBox(height: 30,),

          const Center(
            child: Text.rich(
              TextSpan(
              text: "Didn't receive the code? ",
                children: [
                  TextSpan(
                    text: 'Re-send',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  )
                ]
              )
            )
          ),

          const SizedBox(height: 40,),

          InkWell(
            onTap: () async{
              // add code to verify the code given by the user 
            },
            
            child: appButton(isLoading? 'Verifying...' : 'Submit')
          )

        ],
      ),
    );
  }
}