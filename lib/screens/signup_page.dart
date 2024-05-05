import 'package:flutter/material.dart';
import 'package:employee_management_r/constants/colors.dart';
import 'package:employee_management_r/database/database_helper.dart';
import 'package:employee_management_r/database/database_helper.dart';
import 'package:employee_management_r/screens/login_page.dart';
import 'package:employee_management_r/widgets/custom_date_picker_form_field.dart';
import 'package:employee_management_r/widgets/myButton.dart';
import 'package:employee_management_r/widgets/myTextField.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late double width;
  late double height;
  bool visible = false;
  final bool _loading = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('initState called');

  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void _storeSignUpData() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    // Retrieve values from text controllers
    String username = _usernameController.text;
    String password = _passwordController.text;


    //todo: add username and password values to shared preferences
    //Add Employee Values to Employee database
    await dbHelper.insertUser({
      'username': _usernameController.text,
      'password': _passwordController.text,
    });

    // Insert a new user
    await dbHelper.insertUser({
      'username': username,
      'password': password,
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      // username
                      MyTextField(
                        controller: _usernameController,
                        hint: "Username",
                        icon: Icons.account_box_rounded,
                        validation: (val) {
                          if (val.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                      ),
                      // password
                      MyTextField(
                        controller: _passwordController,
                        hint: "Password",
                        isPassword: true,
                        isSecure: true,
                        icon: Icons.password,
                        validation: (val) {
                          if (val.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),

                      // login button
                      GestureDetector(
                        onTap: () {
                          _storeSignUpData;
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                        },
                        child: MyButton(
                          text: 'SIGNUP',
                          btnColor: primaryColor,
                          btnRadius: 8,
                        ),
                      ),

                      // link to sign up page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: primaryColor, fontSize: 16),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginPage()));
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      )]
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  }

