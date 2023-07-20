import 'package:email_auth/email_auth.dart';

void generateOTP (context, userEmail) async{
  EmailAuth emailAuth = EmailAuth(sessionName: 'OTP Session');
  var res = await emailAuth.sendOtp(recipientMail: userEmail);
  if(res){
    print("OTP Sent");
  }
  else{
    print("Could not send OTP");
  }
}

void verifyOTP(context, userEmail, OTP){
  EmailAuth emailAuth = EmailAuth(sessionName: 'Validate OTP Session');
  var res = emailAuth.validateOtp(recipientMail: userEmail, userOtp: OTP);
  if(res){
    print("OTP Verified");
  }
  else{
    print("Invalid OTP");
  }
}