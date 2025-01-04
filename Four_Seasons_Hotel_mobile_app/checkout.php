<?php
// Enable CORS to handle requests from Flutter
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Database connection details
$conn = mysqli_connect("fdb1029.awardspace.net", "4566111_hotelreservation", "Omar.2003", "4566111_hotelreservation");

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(array("status" => "error", "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
    exit();
}

// Handle OPTIONS method (for pre-flight requests)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type');
    exit();
}

// Handle POST request
// Handle POST request
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        var_dump($_POST);
    // Retrieve data from POST request
    if (isset($_POST['roomId'], $_POST['guestId'], $_POST['checkInDate'], $_POST['checkOutDate'])) {
        $room_id = (int) $_POST['roomId'];     // Room_ID from Flutter (ensuring it's an integer)
        $guest_id = (int) $_POST['guestId'];   // Guest_ID from Flutter (ensuring it's an integer)
        $check_in = $_POST['checkInDate'];   // CheckIn from Flutter
        $check_out = $_POST['checkOutDate']; // CheckOut from Flutter

        // Validate date format (optional but a good practice)
        if (!strtotime($check_in) || !strtotime($check_out)) {
            $response = [
                "status" => "error",
                "message" => "Invalid date format. Please provide valid check-in and check-out dates."
            ];
        } else {
            // Check if the user has already reserved the room within the specified dates
            $check_sql = "
                SELECT * 
                FROM reservation 
                WHERE Room_ID = ? 
                AND Guest_ID = ?
                AND (
                    (CheckIn <= ? AND CheckOut >= ?) OR 
                    (CheckIn <= ? AND CheckOut >= ?)
                )
            ";
            $check_stmt = $conn->prepare($check_sql);

            if ($check_stmt) {
                // Binding parameters as strings since we're passing date values and integers
                $check_stmt->bind_param("iissss", $room_id, $guest_id, $check_in, $check_in, $check_out, $check_out);
                $check_stmt->execute();
                $result = $check_stmt->get_result();

                if ($result->num_rows > 0) {
                    // Reservation already exists
                    $response = [
                        "status" => "error",
                        "message" => "You already have a reservation for this room during the specified dates."
                    ];
                } else {
                    // No existing reservation, proceed to insert
                    $sql = "INSERT INTO reservation (Room_ID, Guest_ID, CheckIn, CheckOut) VALUES (?, ?, ?, ?)";
                    $stmt = $conn->prepare($sql);

                    if ($stmt) {
                        // Insert reservation
                        $stmt->bind_param("ssss", $room_id, $guest_id, $check_in, $check_out);

                        if ($stmt->execute()) {
                            $response = [
                                "status" => "success",
                                "message" => "Reservation successfully saved."
                            ];
                        } else {
                            $response = [
                                "status" => "error",
                                "message" => "Failed to save reservation: " . $stmt->error
                            ];
                        }
                        $stmt->close();
                    } else {
                        $response = [
                            "status" => "error",
                            "message" => "Database error: " . $conn->error
                        ];
                    }
                }
                $check_stmt->close();
            } else {
                $response = [
                    "status" => "error",
                    "message" => "Database error: " . $conn->error
                ];
            }
        }
    } else {
        $response = [
            "status" => "error",
            "message" => "Invalid request. No data received or missing required fields."
        ];
    }

    // Close connection
    $conn->close();

    // Return JSON response
    header("Content-Type: application/json");
    echo json_encode($response);
}

?>
