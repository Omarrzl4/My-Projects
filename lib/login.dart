import 'package:flutter/material.dart';
import 'register.dart';
import 'reservation.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:bcrypt/bcrypt.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email;
  var password;
  var error = "";

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // Fetch client data from the server

  List<dynamic> clientsData = [];
  Future<void> fetchData() async {
    final url = Uri.parse('http://fourseasonshotelsys.atwebpages.com/getClients.php');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        clientsData = json.decode(response.body);
        print('Fetched Data: $clientsData');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  // Function to validate credentials
  void checkCredentials() {
    setState(() {
      email = _email.text;
      password = _password.text;

      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
      if (email.isEmpty || password.isEmpty) {
        error = "Email or password cannot be empty";
      } else if (!emailRegex.hasMatch(email)) {
        error = "Enter a valid email address";
      } else {
        bool isValidUser = false;
        int guestId = -1;

        for (var client in clientsData) {
          if (client['Email'] == email) {
            print('Checking client: ${client['Email']}');
            if (BCrypt.checkpw(password, client['Password'])) {
              isValidUser = true;
              guestId =int.parse( client['ID']);
               
              print(guestId);// Extract the guestId
              break;
            }
          }
        }

        if (isValidUser) {
          _email.clear();
          _password.clear();
          error = "";

          // Navigate to the Reservation screen, passing the guestId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Reservation(guestId: guestId),
            ),
          );
        } else {
          error = "Invalid email or password";
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Four Seasons Hotel"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 500,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welc",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ome",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _email,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _password,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkCredentials,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Don't have an account?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
