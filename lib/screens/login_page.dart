import 'package:employee_management_r/constants/colors.dart';
import 'package:employee_management_r/screens/admin/admin_dashboard.dart';
import 'package:employee_management_r/screens/employee/employee_dashboard.dart';
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

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  void _login(String username, String password) {
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
