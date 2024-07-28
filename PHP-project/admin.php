<?php
include("connection.php");
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
  }
$cerror="";
$nerror="";
$com="";
$time=0;

if(isset($_POST["submit1"])){

     //checking form of client if correct

    if (empty($_POST["cname"])) {
        $cerror = "Client name is required";
      } else {
        $c = test_input($_POST["cname"]);
       
    }

    if (empty($_POST["num"])) {
        $nerror = "Phone Number is required";
      } else {
        $n = test_input($_POST["num"]);
       
    
    if (!is_numeric($n)) {
        $nerror = "Only numbers allowed";
         }
        }


        if(empty($_POST["h1"])||empty($_POST["h2"])||empty($_POST["b1"])||empty($_POST["b2"])){
            $com="Please select both beard and hair";
        }


        if($_POST["h1"]){
            $com="Please select both beard and hair";
        }
        if($_POST["h2"]){
            $com="Please select both beard and hair";
        }
        if($_POST["b1"]){
            $com="Please select both beard and hair";
        }
        if($_POST["b2"]){
            $com="Please select both beard and hair";
        }

        if($_POST["h1"]&&$_POST["b1"]){
            $com="Estimated time is 40 minutes";
            $time=40;
               }

               if($_POST["h1"]&&$_POST["b2"]){
                $com="Estimated time is 20 minutes";
                $time=20;
                   }
                   if($_POST["h2"]&&$_POST["b1"]){
                    $com="Estimated time is 15 minutes";
                    $time=15;
                       }
                       if($_POST["h2"]&&$_POST["b2"]){
                        $com="Please select atleast one choice";
                        $time=0;
                           }


   if($cerror==""&&$nerror=="") {
    $sql="insert into appointments values(Null,'$c',$n,$time)";
    $res=mysqli_query($conn,$sql);
    echo '<script type="text/javascript"> alert("New Client is added successfully") </script>';
   }   
}
   
 
//end of checking


//delete an appointment

if($_SERVER["REQUEST_METHOD"]=="GET"){

    if(isset($_GET['Id'])){
   
  
   $sql1="delete from appointments where Id=".$_GET['Id'];
   
   $quer=@mysqli_query($conn,$sql1);
   

}
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="admin.css">
    <title>Document</title>
</head>
<body>
<center>
   <a href="login.php"><button style="font-size: 50px; background-color:red;color:black; cursor:pointer;">Log Out</button></a>
    <h2>Client Section</h2>
    <hr>
    <form action="admin.php" method="Post">
 
        Client Name: <input type="text" name="cname">
        <span><?php echo $cerror; ?></span>
        <br>

        Phone Number:<input type="text" name="num">
        <span><?php echo $nerror; ?></span>
        <br><br>

       Haircut 
       <br>
       Yes<input type="radio" name="h1">
       No<input type="radio" name="h2">
       <br>
       Beard
       <br>
       Yes<input type="radio" name="b1">
       No<input type="radio" name="b2">
       <br>
       <input type="submit" value="Submit" name="submit1">
       <input type="submit" value="CheckTime">
       <input type="reset" value="Reset">
       <span><?php echo$com; ?></span>
    </form>


    <table border=5>
        <th>Client Name</th>
        <th>Number</th>
        <th>Time(min)</th>
        <th><?php $r=1; echo "<td><a href='admin.php?delAll=".$r."'>Delete All</a></td>";?></th>
        <?php

        //delete all clients

if($_SERVER["REQUEST_METHOD"]=="GET"){
                     
    if(isset($_GET['delAll'])){
   
  
        $sqldel="truncate table appointments";
        $querdel=@mysqli_query($conn,$sqldel);
   

}
}



            //display client table to the admin
        
        
$sql="select * from appointments";
$res=mysqli_query($conn,$sql) or die(mysqli_error($conn));

while($row=mysqli_fetch_array($res)){

echo"<tr>";
echo"<td>".$row['Name']."</td>";
echo"<td>".$row['Number']."</td>";
echo"<td>".$row['Time']."minute</td>";
echo "<td><a href='admin.php?Id=".$row['Id']."'>Delete</a></td>";
echo"</tr>";

}

 


 



//delete a product

if($_SERVER["REQUEST_METHOD"]=="GET"){

    if(isset($_GET['Id'])){
   
  
   $sql1="delete from products where Id=".$_GET['Id'];
   
   $quer=@mysqli_query($conn,$sql1);
   

}
}


 //delete an order
 if($_SERVER["REQUEST_METHOD"]=="GET"){
                     
    if(isset($_GET['Id'])){
   
  
   $sql1="delete from orders where Id=".$_GET['Id'];
   
   $quer=@mysqli_query($conn,$sql1);
   

}
}

//delete all orders

if($_SERVER["REQUEST_METHOD"]=="GET"){
                     
    if(isset($_GET['delAll'])){
   
  
        $sqldel="truncate table orders";
        $querdel=@mysqli_query($conn,$sqldel);
   

}
}

 
?>





<?php
$n1error="";
$p1error="";
$errors="";

if(isset($_POST["submit2"])){

    //checking form of product if correct
 
    
         if (empty($_POST["pname"])) {
             $n1error = "Product name is required";
           } else {
             $n = test_input($_POST["pname"]);
            
         }
     
         if (empty($_POST["price"])) {
             $p1error = "Price is required";
           } else {
             $p = test_input($_POST["price"]);
            
         
         if (!is_numeric($p)) {
             $p1error = "Only numbers allowed";
              }
             }
 
             if(isset($_FILES["pfile"])){
                
                 $file_name=$_FILES["pfile"]["name"];
                 $file_size=$_FILES["pfile"]["size"];
                 $file_tmp=$_FILES["pfile"]["tmp_name"];
                 $file_type=$_FILES["pfile"]["type"];
                 $_file_parts=explode(".",$_FILES["pfile"]["name"]);
                 $file_ext=strtolower(end($_file_parts));
                 $extension=array("jpg","jpeg","png");
 
                 if(in_array($file_ext,$extension)==false){
                     $errors="extension not allowed please choose jpg or png or jpeg";
                 }
 
                 if($file_size>2132932){
                     $errors="file is over 2mb";
                 }
                 echo empty($errors);
                 if(empty($errors)&&$n1error==""&&$p1error==""){
                          move_uploaded_file($file_tmp,"img/".$file_name);
                          $sql="insert into products values(Null,'$n','$file_name',$p)";
                          $res1=mysqli_query($conn,$sql);
                          if($res){
                             $errors="Product added";
                          }
                          else{
                             print_r($errors);
                          }
                 }
 
 
             }
      
 }
 //end of checking

?>


    
    </table>
    
    <br>
    <h2>Product Section</h2>
    <hr>
    <center> 
        <form action="admin.php" method="post" enctype="multipart/form-data"> 
    Product Name: <input type="text" name="pname">
    <span><?php echo $n1error ?></span>
    <br>
    Product Price: <input type="text" name="price">
    <span><?php echo $p1error ?></span>
    <br>
    Product Image : <input type="file" name="pfile">
      <input type="submit" value="Submit" name="submit2">
      <input type="reset" value="Reset">
      <br>
      <span><?php echo $errors ?></span>


    </form>

      <table border=5>
         
        <th>Product Name</th>
        <th>Price</th>

      <?php
            
        //display table product to the admin
        
            $sql="select * from products";
            $res=mysqli_query($conn,$sql) or die(mysqli_error($conn));
            
            while($row=mysqli_fetch_array($res)){
            
            echo"<tr>";
            echo"<td>".$row['Name']."</td>";
            echo"<td>$".$row['Price']."</td>";
            echo "<td><a href='admin.php?Id=".$row['Id']."'>Delete</a></td>";
            echo"</tr>";
            
            }
            
            ?> 


      </table>




    </center>

    <h2>Orders</h2>
    <hr>
    
      <table border="5">
        <th>Items</th>
        <th>Phone Number</th>
        <th><?php $r=1; echo "<td><a href='admin.php?delAll=".$r."'>Delete All</a></td>";?></th>

      <?php
            
            //display the orders to the admin
            
                $sql="select * from orders";
                $res=mysqli_query($conn,$sql) or die(mysqli_error($conn));
                
                while($row=mysqli_fetch_array($res)){
                    $num=$row['Phone'];
                 if($num){
                echo"<tr>";
                echo"<td>".$row['Item']."</td>";
                echo"<td>".$row['Phone']."</td>";
                echo "<td><a href='admin.php?Id=".$row['ID']."'>Delete</a></td>";
                echo"</tr>";
                 }
               
                }
                  
                
                ?> 

      </table>

</body>
</html>


