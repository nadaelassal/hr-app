// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hr_app/constants/strings.dart';



class DataScreen extends StatefulWidget {
  
   DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: BlocProvider<PhoneAuthCubit>(
              create: (context) =>phoneAuthCubit,
              child: ElevatedButton(
                onPressed: ()async {
                  await phoneAuthCubit.logOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacementNamed(loginScreen);
                },
                // ignore: sort_child_properties_last,
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(110, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
           Container(
            child: Center(
              child: 
                Container(
                  padding: EdgeInsets.all(20),
          
                    child: ElevatedButton(
                      onPressed: ()async {
                    Navigator.of(context).pushNamed(dataBaseScreen);
    
                      },
                      // ignore: sort_child_properties_last,
                     child: Text(
                        'Show data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(110, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              
            ),
        ],
          ),
        
      );
      
    
  }
}
