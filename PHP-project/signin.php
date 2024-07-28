<?php
include("connection.php");

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
  }
$eerror="";
$perror="";
$uerror="";
$aerror="";


if($_SERVER["REQUEST_METHOD"]=="POST"){
    if (empty($_POST["email"])) {
        $eerror = "Email is required";
      } else {
        $e = test_input($_POST["email"]);
       
    }

    if (empty($_POST["password"])) {
        $perror = "Password is required";
      } else {
        $p = test_input($_POST["password"]);
        
    }


    if (empty($_POST["username"])) {
        $uerror = "Username is required";
      } else {
        $u = test_input($_POST["username"]);
       
    }

    if (empty($_POST["age"])) {
        $aerror = "Age is required";
      } else {
        $a = test_input($_POST["age"]);
      
        if (!is_numeric($a)) {
     $aerror = "Only numbers allowed";
      }


}


if($eerror =="" &&  $perror =="" && $uerror=="" && $aerror==""){
    $sql="insert into users values (Null,'$e','$p','$u','$a')";
    $result=mysqli_query($conn,$sql) or die(mysqli_error($conn));
    echo'<script type="text/javascript">alert("Welcome")</script>';
    header("Location:home.php");
}
mysqli_close($conn);

}
?>









<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="sigin.css">
    <title>Document</title>
</head>
<body>
    <form action="signin.php" method="Post">
        <center>
            
            <h1>Welcome to <span class="store">H&B</span></h1>
            <h3>Sign in to recieve to stay updated !</h3>
            <label >Email:</label> <input type="email" name="email"> <span><?php echo $eerror; ?></span>
            <br>
            <label >Password:</label> <input type="password" name="password"> <span><?php echo $perror; ?></span>
            <br>
            <label >Username:</label> <input type="text" name="username"> <span><?php echo $uerror; ?></span>
            <br>
            <label >Age:</label><input type="text" name="age"> <span><?php echo $aerror; ?></span>
            <br>
            <input type="submit" value="Submit">
            <br>
            <input type="reset" value="Reset">
            <br>
            <p>Already have an account ? <a href="login.php">Log In!</a></p>

        </center>
         
    </form>
    
</body>
</html>