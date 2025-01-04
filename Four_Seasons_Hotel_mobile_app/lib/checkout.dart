import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'login.dart';
class Checkout extends StatelessWidget {
  final int roomID;
  final int roomNumber;
  final String roomName;
  final String category;
  final double price;
  final double totalPrice;
  final int days;
  final int guestId; // Add guest ID
  final DateTime checkInDate; // Add check-in date
  final DateTime checkOutDate; // Add check-out date

  Checkout({
    required this.roomID,
    required this.roomNumber,
    required this.roomName,
    required this.category,
    required this.price,
    required this.totalPrice,
    required this.days,
    required this.guestId,
    required this.checkInDate,
    required this.checkOutDate,
  });

  Future<void> confirmBooking(BuildContext context) async {
    print("${guestId}");
    print("${roomID}");
    print("${checkInDate}");
    print("${checkOutDate}");
    try {
      print(checkInDate);
      // Format the dates as strings
      String formattedCheckInDate =
          '${checkInDate.year}-${checkInDate.month.toString().padLeft(2, '0')}-${checkInDate.day.toString().padLeft(2, '0')}';
      String formattedCheckOutDate =
          '${checkOutDate.year}-${checkOutDate.month.toString().padLeft(2, '0')}-${checkOutDate.day.toString().padLeft(2, '0')}';
      print("${guestId}");
      print("${roomID}");
      print("${formattedCheckInDate}");
      print("${formattedCheckOutDate}");
      // Send data to the PHP API
      final response = await http.post(

        Uri.parse('http://fourseasonshotelsys.atwebpages.com/checkout.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded', // Ensure compatibility with PHP $_POST
        },
        body: {
          'roomId': roomID.toString(),
          'guestId': guestId.toString(),
          'checkInDate': formattedCheckInDate,
          'checkOutDate': formattedCheckOutDate,
        },
      );

      if (response.statusCode == 200) {
        // Parse server response
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error:')),
             );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Failed to confirm booking.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to confirm booking. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking confirmed...:')),


      );
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Room Name: $roomName",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Room Number: $roomNumber", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Category: $category", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Price per Night: \$${price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Number of Days: $days", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Total Price: \$${totalPrice.toStringAsFixed(2)}",
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => confirmBooking(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
                child: Text("Confirm Booking",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
