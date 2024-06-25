<?php
 include("connection.php");
 include("header.php");
 
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="product.css">
</head>
<body>
     <center> 
   
<h3>Here are Some of Our Amazing Products: </h3>

</center>


   

         
        
 
       <?php
             //display products
             $sql="select * from products";
             $res=mysqli_query($conn,$sql) or die(mysqli_error($conn));
             
             while($row=mysqli_fetch_array($res)){
             
            echo"<div class='products'>";
               
            echo "<img src=img/".$row['Image'].">";
            echo"<br>"; 
           
            echo"<span>".$row['Name'];
            echo"<br>"; 
            echo"<p> Price:$".$row['Price'];
            echo"<br>";
            echo"<br>";
            echo"<a href='products.php?Id=".$row['Id']."'>Addtocart</a>";
            echo"</div>";
           
             }


             if($_SERVER["REQUEST_METHOD"]=="GET"){
             
                //addtocart code
                //creating two sql queries
                if(isset($_GET['Id'])){
               $sqls="select Name,Price from products where Id=".$_GET['Id'];
               $sqlq=mysqli_query($conn,$sqls);

                 while($row1=@mysqli_fetch_array($sqlq)){
                   
              $a=$row1['Name'];
              $b=$row1['Price'];
               $sql1="insert into cart values (Null,'$a','$b')";
               $quer=@mysqli_query($conn,$sql1);
                     
                        
                     
                    
                        echo"<h3>product added </h3> ";
                     
            }
             
          
            }
            }
             
             ?> 

 
     
</body>
</html>