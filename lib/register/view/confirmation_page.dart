import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailConfirmationPage extends StatefulWidget {
  EmailConfirmationPage({Key? key}) : super(key: key);

  @override
  State<EmailConfirmationPage> createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  bool isEmailVerified = false;
  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
