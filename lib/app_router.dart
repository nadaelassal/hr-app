// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hr_app/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hr_app/constants/strings.dart';
import 'package:hr_app/presentation/screens/database_screen.dart';
import 'package:hr_app/presentation/screens/home_screen.dart';
import 'package:hr_app/presentation/screens/login_screen.dart';
import 'package:hr_app/presentation/screens/otp_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dataScreen:
        return MaterialPageRoute(
          builder: (_) => DataScreen(),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );
      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      case dataBaseScreen:
        return MaterialPageRoute(
          builder: (_) => DatabaseScreen(),
        );
    }
  }
}
