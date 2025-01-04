import 'package:flutter/material.dart';
import 'package:mobile_final_project/rooms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For handling JSON data
import 'login.dart';

class Reservation extends StatefulWidget {
  final int guestId;

  const Reservation({Key? key, required this.guestId}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  var adults;
  var children;
  var error = "";
  var success = "";

  TextEditingController _numberofadults = TextEditingController();
  TextEditingController _numberofchildren = TextEditingController();

  DateTime? _displaycheckIn;
  DateTime? _displaycheckOut;

  String formatDate(DateTime? date) {
    if (date == null) {
      return 'Select a date';
    }
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }



  // Function to call the API
  Future<void> sendReservationData() async {
    try {
      // API endpoint
      var url = Uri.parse('http://fourseasonshotelsys.atwebpages.com/getRooms.php');

      // Convert dates to strings for the API request
      String checkIn = _displaycheckIn != null ? formatDate(_displaycheckIn) : '';
      String checkOut = _displaycheckOut != null ? formatDate(_displaycheckOut) : '';

      // Send POST request with check-in, check-out dates and guestId
      var response = await http.post(
        url,
        body: json.encode({
          'guestId': widget.guestId,
          'checkInDate': checkIn,
          'checkOutDate': checkOut,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response if the request is successful
        var data = json.decode(response.body);
        print('Response: $data');
        setState(() {
          success = "Reservation data sent successfully!";
        });
      } else {
        setState(() {
          error = "Failed to send reservation data.";
        });
      }
    } catch (e) {
      setState(() {
        error = "Error occurred: $e";
      });
    }
  }

  void checkCredentials() {
    adults = _numberofadults.text;

    if (adults.isEmpty) {
      setState(() {
        error = "Please enter a valid number for adults";
        success = "";
      });
      return;
    }

    if (_displaycheckIn == null || _displaycheckOut == null) {
      setState(() {
        error = "Please select valid check-in and check-out dates";
        success = "";
      });
      return;
    }

    if (_displaycheckOut!.isBefore(_displaycheckIn!)) {
      setState(() {
        error = "Check-out date must be after the check-in date";
        success = "";
      });
      return;
    }

    setState(() {
      error = "";
      success = "Great! Your search is ready.";
    });

    // Call the function to send the data to the API
    sendReservationData();

    // Navigate to the next screen after the API request
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomListPage(
          checkInDate: _displaycheckIn!,
          checkOutDate: _displaycheckOut!,
          guestId: widget.guestId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Four Seasons Hotel"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate to the Login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );// Use your login route
            },
            tooltip: 'Sign Out',
          ),
        ],
      ),

      backgroundColor: Colors.grey[400],
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Adults input
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        TextField(
                          controller: _numberofadults,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Adults:',
                            labelStyle: TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _numberofchildren,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Children:',
                            labelStyle: TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  // Check-in and check-out dates
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        Text(
                          "Check in: ${formatDate(_displaycheckIn)}",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        CalendarDatePicker(
                          initialDate: _displaycheckOut ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                          onDateChanged: (DateTime newDate) {
                            setState(() {
                              _displaycheckIn = newDate;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        Text(
                          "Check out: ${formatDate(_displaycheckOut)}",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        CalendarDatePicker(
                          initialDate: _displaycheckIn ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                          onDateChanged: (DateTime newDate) {
                            setState(() {
                              _displaycheckOut = newDate;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Search button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: checkCredentials,
                    child: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Error and success messages
                  Text(
                    "$error",
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$success",
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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