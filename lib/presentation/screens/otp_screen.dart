// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hr_app/constants/mycolors.dart';
import 'package:hr_app/constants/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key, this.phoneNumber});

   final phoneNumber ;
   late  String otpCode ;

Widget _buildIntroTexts () {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number ',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
 
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(text: 'Enter your 6 digit numbers sent to ',
            style: TextStyle(color: Colors.black , fontSize: 18 , height: 1.4),
            children: <TextSpan>[
              TextSpan(
                text: '$phoneNumber' ,
                style: TextStyle(color: MyColors.blue),
              ),
            ],
            ),
            
            ),
          ),
      
      ],
    );
}
  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

Widget _buildPinCodeFeild (BuildContext context) {
  return Container(
child: PinCodeTextField(
  appContext: context,
  autoFocus: true,
  cursorColor: Colors.black,
  keyboardType: TextInputType.number,
  length: 6,
  obscureText: false,
  animationType: AnimationType.scale,
  pinTheme: PinTheme(
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 40,
    fieldWidth: 30,
    borderWidth: 1,
    activeColor: MyColors.blue,
    inactiveColor: MyColors.blue,
    inactiveFillColor: Colors.white,
    activeFillColor: MyColors.lightBlue,
    selectedColor: MyColors.blue,
    selectedFillColor: Colors.white,
  ),
  animationDuration: Duration(milliseconds: 300),
  backgroundColor: Colors.white,
  enableActiveFill: true,
  onCompleted: (code) {
  otpCode = code ;
    
    print("Completed");
  },
  onChanged: (value) {
    print(value);
    }
),
  );
}

void _login (BuildContext context){
  BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
}

Widget _buildVerifyButton (BuildContext context) {
   return Align(
    alignment: Alignment.centerRight,
    child: ElevatedButton(onPressed: () {
      showProgressIndicator(context);
      _login(context);
    },
    child: Text(
      'Verify',
      style: TextStyle(color: Colors.white , fontSize: 12,),
    ),
    style: ElevatedButton.styleFrom(
      minimumSize: Size(80, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),
      backgroundColor: Colors.black,
      
    ),
   ),
   );
}
_buildPhoneVerificationBloc(){
   return BlocListener<PhoneAuthCubit , PhoneAuthState>(
    listenWhen: (previous, current) {
    return previous != current ;
  }, listener: ( context,  state) {
    if(state is Loading){
      showProgressIndicator(context);
    }
     if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(dataScreen,);
        }
         if (state is ErrorOccured) {
          //Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }

    },
    child: Container(),
    );
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        margin: EdgeInsets.symmetric(horizontal: 32 , vertical: 35),
        child: Column(
          children: [
            _buildIntroTexts(),
            SizedBox(height:50,),
            _buildPinCodeFeild(context),
            SizedBox(height: 50,),
            _buildVerifyButton(context),
            _buildPhoneVerificationBloc(),
          ],
        ),
      ) ,
    ),
    );
  }
}