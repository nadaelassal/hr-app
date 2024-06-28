// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credntial) async {
    print('verificationCompleted');
    await signIn(credntial);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed :${error.toString()}');
    emit(ErrorOccured(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('code sent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('verificationCompleted');
  }

  Future<void>submitOTP(String otpCode)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: this.verificationId, smsCode: otpCode);

      await signIn(credential);
  }

  Future<void> signIn (PhoneAuthCredential credential)async {
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    }catch(error){
      emit(ErrorOccured(errorMsg: error.toString()));
    }

  }
  Future <void> logOut()async{
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser(){
    return FirebaseAuth.instance.currentUser!;
  }
  }
