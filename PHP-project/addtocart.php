<?php
include("connection.php");
include("header.php");

//delete am item from cart

if($_SERVER["REQUEST_METHOD"]=="GET"){

  if(isset($_GET['id'])){
 

 $sql1="delete from cart where ID=".$_GET['id'];
 
 $quer=@mysqli_query($conn,$sql1);
  }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="addtocart.css">
</head>
<body>
    <center>
    <h2 style="color: whitesmoke;">Your Items:</h2>
    <form action="addtocart.php" method="post">
    <table border=5 style="color: white; background-color:black; font-size:40px;">

     <th>Item</th>
     <th>Price </th>
      
     <?php

      //display the cart item and their sum

    $sum=0;
     
     $sql="select * from cart";
    
     $res=mysqli_query($conn,$sql) or die(mysqli_error($conn));
     
     while($row=mysqli_fetch_array($res)){
     
     echo"<tr>";
     echo"<td>".$row['Name']."</td>";
     echo"<td>$".$row['Price']."</td>";
     echo "<td><a href='addtocart.php?id=".$row['ID']."'>Delete</a></td>";
     echo"</tr>";
     $sum+=$row['Price'];
     }

      

     
     ?>
       
    </table>

      <?php
 echo"<h1>The total is $".$sum."</h1>";


 function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}


     $error="";
 if($_SERVER["REQUEST_METHOD"]=="POST"){

  
  //sending order to the admin
  
  $p = test_input($_POST["phone"]);

  if (!is_numeric($p)) {
  
    $error = "Only numbers allowed";
     }
     
     else{

     $sql="select * from cart";
    
     $res=mysqli_query($conn,$sql) or die(mysqli_error($conn));

     while($row1=@mysqli_fetch_array($res)){
      if(empty($row1['Name']) && empty($row1['Price'])){
        $error="No items was selected!"; 
              
             } 
             else{
              $b=$row1['Name'];
              $c=$row1['Price'];
              $d=$_POST['phone'];
               $sql1="insert into orders values (NULL,'$b','$c','$d')";
               $querr=@mysqli_query($conn,$sql1);
               if($querr){
                $error="Thanks for buying !";
                
                $sqldel="truncate table cart";
                $querdel=@mysqli_query($conn,$sqldel);
               }
                
               }
            }

          }
 }

?>
<h2 style="color: whitesmoke;">Phone number:</h2><input type="text" name="phone">
<br>
<span><?php echo $error ?></span>
<input type="submit" value="Submit" >

</form>
 
 

</body>
</html>


