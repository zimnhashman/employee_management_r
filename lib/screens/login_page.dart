import 'package:employee_management_r/constants/colors.dart';
import 'package:employee_management_r/screens/admin/admin_dashboard.dart';
import 'package:employee_management_r/screens/employee/employee_dashboard.dart';
import 'package:employee_management_r/widgets/mybutton.dart';
import 'package:employee_management_r/widgets/mytextfield.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;
  final bool _loading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }


  //
  // void _perfomLogin() async {
  //   String username = _usernameController.text.trim();
  //   String password = _passwordController.text.trim();
  //
  //   if (username.isNotEmpty && password.isNotEmpty) {
  //     // For demonstration purposes, let's check against a local database.
  //     Map<String, dynamic> user = await _databaseHelper.getUserByUsername(username);
  //
  //     if (user.isNotEmpty && user['password'] == password) {
  //       // Successful login
  //       _showSnackbar('Login successful!');
  //       Get.to(() =>
  //           Dashboard(
  //             name: _usernameController.text,
  //             userId: _usernameController.text,
  //           ));
  //     } else {
  //       // Failed login
  //       _showSnackbar('Invalid username or password.');
  //     }
  //   } else {
  //     _showSnackbar('Please enter both username and password.');
  //   }
  // }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    // Image.asset(
                    //   'assets/images/login_image.png', height: MediaQuery
                    //     .of(context)
                    //     .size
                    //     .height * 0.35,),
                    const SizedBox(height: 20),
                    // username
                    MyTextField(
                      controller: _usernameController,
                      hint: "Username",
                      icon: Icons.person,
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
                      icon: Icons.lock,
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
                        // _performLogin();
                        if (_usernameController.text == 'admin' &&
                            _passwordController.text == 'admin') {
                          void showSnackbar(BuildContext context) {
                            final snackBar = SnackBar(
                              content: Text('${_usernameController
                                  .text} logged in successfully'),
                              duration: const Duration(seconds: 5),
                              // Optional, default is 4 seconds
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            );
                            // Show the snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          }
                          showSnackbar(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>  AdminDashboard(username: _usernameController.text,)));
                        } else if (_usernameController.text ==
                            'employee' &&
                            _passwordController.text == 'employee') {
                          void showSnackbar(BuildContext context) {
                            final snackBar = SnackBar(
                              content: Text('${_usernameController
                                  .text} logged in successfully'),
                              duration: const Duration(seconds: 5),
                              // Optional, default is 4 seconds
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            );
                            // Show the snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          }
                          showSnackbar(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Dashboard(
                                        name: _usernameController.text,
                                        userId: _usernameController.text,
                                      )));
                        } else {
                          // _perfomLogin();
                           void showSnackbar(BuildContext context) {
                            final snackBar = SnackBar(
                              content: const Text(
                                  'Database Log In Successful!'),
                              duration: const Duration(seconds: 5),
                              // Optional, default is 4 seconds
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            );
                            // Show the snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          }
                          showSnackbar(context);

                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (_) =>
                                       Dashboard(
                                         name: _usernameController.text,
                                         userId: _usernameController.text,
                                       )));
                        }
                      },
                      child: const MyButton(
                        text: 'LOGIN',
                        btnColor: primaryColor,
                        btnRadius: 8,
                      ),
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

}
