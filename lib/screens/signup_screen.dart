import 'package:flutter/material.dart';
import '../widget/text_form_field.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
            // backgroundColor: Colors.black87,
            centerTitle: true,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/welcome/1.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(text: 'Name', type: 'text'),
                            CustomTextFormField(text: 'Email', type: 'email'),
                            CustomTextFormField(text: 'Password', type: 'password'),
                            CustomTextFormField(text: 'RePassword', type: 'password'),
                            // Submit Button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );

  }
}
