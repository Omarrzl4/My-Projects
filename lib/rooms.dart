import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'checkout.dart';
import 'login.dart';

class Room {
  final int roomID;
  final int roomNumber;
  final String roomName;
  final String category;
  final String description;
  final double price;
  final String image;

  Room({
    required this.roomID,
    required this.roomNumber,
    required this.roomName,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  // Factory constructor to create Room object from JSON data
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomID:json['ID'],
      roomNumber: json['RoomNumber'],
      roomName: json['RoomName'],
      category: json['RoomCategory'],
      description: json['Description'],
      price: double.parse(json['RoomPrice'].toString()),
      image: json['RoomImage'].replaceAll(r'\/', '/'), // Replace escaped slashes
    );
  }
}

class RoomListPage extends StatefulWidget {
  final int guestId;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  RoomListPage({
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestId,
  });

  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  List<Room> rooms = [];
  bool isLoading = true;
  String errorMessage = '';

  // Method to fetch room data from PHP API
  Future<void> fetchRoomData() async {
    try {
      // Format the check-in and check-out date to remove time
      String formattedCheckInDate =
          '${widget.checkInDate.year}-${widget.checkInDate.month.toString().padLeft(2, '0')}-${widget.checkInDate.day.toString().padLeft(2, '0')}';
      String formattedCheckOutDate =
          '${widget.checkOutDate.year}-${widget.checkOutDate.month.toString().padLeft(2, '0')}-${widget.checkOutDate.day.toString().padLeft(2, '0')}';

      final response = await http.post(
        Uri.parse('http://fourseasonshotelsys.atwebpages.com/getRooms.php'),
        body: {
          'checkInDate': formattedCheckInDate,
          'checkOutDate': formattedCheckOutDate,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          rooms = data.map((item) => Room.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load rooms';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRoomData(); // Fetch room data when the page is loaded
  }

  // Method to calculate number of days between check-in and check-out
  int calculateDays(DateTime checkIn, DateTime checkOut) {
    return checkOut.difference(checkIn).inDays;
  }

  // Method to handle room selection
  void handleRoomButtonClick(Room room, BuildContext context) {
    final int days = calculateDays(widget.checkInDate, widget.checkOutDate);
    final double totalPrice = days * room.price;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Checkout(
          roomID:room.roomID,
          roomNumber: room.roomNumber,
          roomName: room.roomName,
          category: room.category,
          price: room.price,
          totalPrice: totalPrice,
          days: days,
          guestId: widget.guestId, // Pass guestId to Checkout page
          checkInDate: widget.checkInDate, // Pass check-in date to Checkout page
          checkOutDate: widget.checkOutDate, // Pass check-out date to Checkout page
        ),
      ),
    );
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Display the room image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(

                      "../imgs/${room.image}",
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Image not available');
                      },
                    ),

                ),
                ListTile(
                  title: Text(room.roomName),
                  subtitle: Text(
                      "Category: ${room.category}, Price: \$${room.price}, Room Number: ${room.roomNumber}, Description: ${room.description}"),
                ),
                ElevatedButton(
                  onPressed: () => handleRoomButtonClick(room, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  ),
                  child: Text("Book",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

