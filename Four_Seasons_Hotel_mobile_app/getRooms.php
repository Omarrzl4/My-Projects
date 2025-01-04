<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Ensure the request method is POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(array("error" => "Invalid request method."));
    exit();
}

// Get data from POST request
$checkIn = isset($_POST['checkInDate']) ? trim($_POST['checkInDate']) : null;
$checkOut = isset($_POST['checkOutDate']) ? trim($_POST['checkOutDate']) : null;

// Log the incoming data for debugging
error_log("Received check-in date: " . $checkIn);
error_log("Received check-out date: " . $checkOut);

// Check if both check-in and check-out dates are provided
if ($checkIn && $checkOut) {
    // Convert dates into a format that is compatible with MySQL (YYYY-MM-DD)
    $checkIn = date('Y-m-d', strtotime($checkIn));
    $checkOut = date('Y-m-d', strtotime($checkOut));

    // Log the converted dates for debugging
    error_log("Converted check-in date: " . $checkIn);
    error_log("Converted check-out date: " . $checkOut);

    // Connect to MySQL database
    $con = mysqli_connect("fdb1029.awardspace.net", "4566111_hotelreservation", "Omar.2003", "4566111_hotelreservation");

    // Check connection
    if (mysqli_connect_errno()) {
        echo json_encode(array("error" => "Failed to connect to MySQL: " . mysqli_connect_error()));
        exit();
    }

    // Prepare the SQL query with placeholders
    $query = "SELECT r.ID, r.RoomName, r.RoomNumber, r.RoomCategory, r.Description, r.RoomPrice, r.RoomImage
              FROM rooms r
              LEFT JOIN reservation res
              ON r.ID = res.Room_ID
              AND NOT (
                  res.CheckOut <= ? OR  
                  res.CheckIn >= ?
              )
              WHERE res.Room_ID IS NULL;";

    // Prepare statement
    if ($stmt = mysqli_prepare($con, $query)) {
        // Bind parameters to the prepared statement
        mysqli_stmt_bind_param($stmt, "ss", $checkIn, $checkOut); // "ss" indicates two string parameters

        // Execute the prepared statement
        if (mysqli_stmt_execute($stmt)) {
            // Get the result
            $result = mysqli_stmt_get_result($stmt);

            // Fetch the results and store them in an array
            $emparray = array();
            while ($row = mysqli_fetch_assoc($result)) {
                // Construct the full URL for the image
                $imageBaseUrl = 'http://fourseasonshotelsys.atwebpages.com/imgs/';
                $row['RoomImage'] = $row['RoomImage'];  // Append the image filename to the base URL
                $emparray[] = $row;
            }

            // Return the results as a JSON response
            echo json_encode($emparray);

            // Free result set and close the prepared statement
            mysqli_free_result($result);
            mysqli_stmt_close($stmt);
        } else {
            // If the query couldn't be executed
            echo json_encode(array("error" => "Failed to execute the SQL query."));
        }
    } else {
        // If the query couldn't be prepared
        echo json_encode(array("error" => "Failed to prepare the SQL query."));
    }

    // Close the connection
    mysqli_close($con);
} else {
    // Return an error if dates are not provided
    echo json_encode(array("error" => "Both check-in and check-out dates are required."));
}
?>  