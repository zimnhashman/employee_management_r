import 'package:employee_management_r/constants/colors.dart';
import 'package:employee_management_r/database/database_helper.dart';
import 'package:employee_management_r/screens/admin/admin_dashboard.dart';
import 'package:employee_management_r/screens/employee/employee_dashboard.dart';
import 'package:employee_management_r/screens/signup_page.dart';
import 'package:employee_management_r/widgets/mybutton.dart';
import 'package:employee_management_r/widgets/mytextfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _login(String username, String password) async {

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      // For demonstration purposes, let's check against a local database.
      // Map<String, dynamic> user = await databaseHelper.getUserByUsername(username);

      // if (user.isNotEmpty && user['password'] == password) {
      //   // Successful login
      //   _showSnackbar('Login successful!');
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AdminDashboard(username: _usernameController.text)));
      // } else {
      //   // Failed login
      //   _showSnackbar('Invalid username or password.');
      // }
    } else {
      _showSnackbar('Please enter both username and password.');
    }
    if (username == 'admin' && password == 'admin') {
      _showSnackbar('$username logged in successfully');
      Navigator.push(context, MaterialPageRoute(builder: (_) => AdminDashboard(username: _usernameController.text)));
    } else if (username == 'employee' && password == 'employee') {
      _showSnackbar('$username logged in successfully');
      Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard(name: _usernameController.text, userId: _usernameController.text)));
    } else {
      _showSnackbar('Incorrect username or password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _usernameController,
                    hint: "Username",
                    icon: Icons.person,
                    validation: (val) => val.isEmpty ? "Username is required" : null,
                  ),
                  MyTextField(
                    controller: _passwordController,
                    hint: "Password",
                    isPassword: true,
                    isSecure: true,
                    icon: Icons.lock,
                    validation: (val) => val.isEmpty ? "Password is required" : null,
                  ),
                  GestureDetector(
                    onTap: () {
                      _login(
                        _usernameController.text.trim(),
                        _passwordController.text.trim(),
                      );

                    },
                    child: const MyButton(
                      text: 'LOGIN',
                      btnColor: primaryColor,
                      btnRadius: 8,
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  GestureDetector(
                    onTap:  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUp())),
                      child:  const Text('Not Registered........Sign Up Here!', style: TextStyle(
                        fontSize: 15.0,
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
