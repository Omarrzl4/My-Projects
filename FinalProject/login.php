<?php

session_start();
include("connection.php");
$uerror="";


if($_SERVER["REQUEST_METHOD"]=="POST"){
    $sql="select * from clients where username='" . $_POST["username"] . "' and password = '". $_POST["password"]."'";
    $res=mysqli_query($conn,$sql);
    $row=mysqli_fetch_array($res);


if($_POST['username']=='admin123'&&$_POST['password']=='admin01'){
    header("Location:admin.php"); 
}
else{
   


   
    if(is_array($row)){
     //create a session
    $_SESSION['user']=$row['Username'];
    $_SESSION['pass']=$row['Password'];
     
    }



     else{
       unset($_SESSION['user']);
       unset($_SESSION['pass']);
       $uerror="Invalid name or password";
       
     }


     if(isset($_SESSION['user'])) {
        header("Location:home.php"); 
        }

        


    }

}

?>





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="login.css">
    <title>Document</title>
</head>
<body> 
    <form action="login.php" method="post"> 
        <center> 
        <label for=>Username</label> <input type="text" name="username">
        
        <br>
        <label>Password</label> <input type="password" name="password">
       
        <br>
        <span> <?php echo $uerror; ?></span>
        <br>

        <input type="submit" value="Submit">
        <br>
        
        <input type="reset" value="Reset">
          <br>

          <a href="signin.php">Sign in</a>

        </center>
             
    </form>
</body>
</html>