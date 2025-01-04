import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcrypt/bcrypt.dart';
import 'reservation.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var name;
  var username;
  var email;
  var password;
  var error = "";

  TextEditingController _name = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // Function to hash the password
  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    int month = now.month;
    int day = now.day;
    int year = now.year;

    // Format the date as MM/dd/yyyy
    return '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year';
  }


  // Function to validate credentials and register the user
  Future<void> registerUser() async {
    setState(() {
      name = _name.text.trim();
      username = _username.text.trim();
      email = _email.text.trim();
      password = _password.text.trim();

      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

      if (name.isEmpty) {
        error = "Name cannot be empty";
      } else if (username.isEmpty) {
        error = "Username cannot be empty";
      } else if (email.isEmpty || !emailRegex.hasMatch(email)) {
        error = "Enter a valid email address";
      } else if (password.isEmpty || password.length < 6) {
        error = "Password must be at least 6 characters";
      } else {
        error = ""; // Clear the error if everything is valid

        // Hash the password before sending to the server
        String hashedPassword = hashPassword(password);

        // Make the API request to register the user
        registerToServer(name, username, email, hashedPassword);
      }
    });
  }

  // Function to make a POST request to register the user on the server
  Future<void> registerToServer(String name, String username, String email, String hashedPassword) async {
    final url = Uri.parse('http://fourseasonshotelsys.atwebpages.com/register.php');

    // Get the current date in MM/dd/yyyy format
    String currentDate = getCurrentDate();

    try {
      final response = await http.post(url, body: {
        'name': name,
        'username': username,
        'email': email,
        'password': hashedPassword,
        'dateCreated': currentDate,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Server Response: $responseData"); // Debugging log

        if (responseData['status'] == 'success') {
          // Extract guestId
          final int? guestId = responseData['guestId'];

          if (guestId != null) {
            print("Extracted guestId: $guestId"); // Debugging log

            // Navigate to the Reservation screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Reservation(guestId: guestId),
              ),
            );
          } else {
            setState(() {
              error = "Guest ID is missing from the server response.";
            });
          }
        } else {
          setState(() {
            error = responseData['message'] ?? "Registration failed, please try again.";
          });
        }
      } else {
        setState(() {
          error = "Server error: ${response.statusCode}";
        });
      }
    } catch (e) {
      print("Error occurred: $e");
      setState(() {
        error = "Exception: $e";
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Four Seasons Hotel"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Be ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "Our ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "Guest",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Name Field
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your name",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Username Field
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your username",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Email Field
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Password Field
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Register Button
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),

                // Display error message if any
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
