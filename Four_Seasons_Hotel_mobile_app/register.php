<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Database connection
$conn = mysqli_connect("fdb1029.awardspace.net", "4566111_hotelreservation", "Omar.2003", "4566111_hotelreservation");

// Check connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get the POST data from Flutter
    $name = $_POST['name'];
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password']; // This is already hashed
    $dateCreated = $_POST['dateCreated'];  // Get the dateCreated from Flutter

    // Check if the email already exists
    $checkEmailQuery = "SELECT * FROM guest WHERE Email = ?";
    $stmt = $conn->prepare($checkEmailQuery);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Email already exists
        echo json_encode(["status" => "error", "message" => "Email is already registered"]);
    } else {
        // Email is not registered, insert new user
        $insertQuery = "INSERT INTO guest (Name, Username, Email, Password, DateCreated) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($insertQuery);
        $stmt->bind_param("sssss", $name, $username, $email, $password, $dateCreated);
        
        if ($stmt->execute()) {
            // Fetch the auto-generated guestId
            $guestId = $conn->insert_id;

            // Return success response with guestId
            echo json_encode([
                "status" => "success",
                "message" => "Registration successful",
                "guestId" => $guestId
            ]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to register"]);
        }
    }

    $stmt->close();
    $conn->close();
}
?>
