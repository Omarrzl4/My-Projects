<?php
include("header.php");
include("connection.php");
 
?>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<center> 
    <h1 style="color: white;">For appointments  <a href="tel:+70630615"> <i class="fa-solid fa-phone fa-shake fa-2xl" style="color: #00ff11;"></i></a></h1>
    
    <table border=5 style="color: white; background-color:black; font-size:40px;">
     <th>Name</th>
     <th>Phone number</th>
     <th>Estimated Time(min)</th>
   
    <?php
     $time=0;
     $sql="select * from appointments";
    
     $res=mysqli_query($conn,$sql) or die(mysqli_error($conn));
     
     while($row=mysqli_fetch_array($res)){
     
     echo"<tr>";
     echo"<td>".$row['Name']."</td>";
     echo"<td>".$row['Number']."</td>";
     echo"<td>".$row['Time']." minute</td>";

     echo"</tr>";
     $time+=$row['Time'];
      
     }
     echo"<h1 style='color: white;'>Your waiting time is about ".$time." minutes</h1>";
     
     ?>

     


</center>
     </table>
     <script src="https://kit.fontawesome.com/dc2ea9fd85.js" crossorigin="anonymous"></script>
</body>
</html>
<?php
include("footer.php");

?>