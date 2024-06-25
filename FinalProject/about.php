<?php 
include("header.php");

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="about.css">
    <title>Document</title>
</head>
<body>
    <center> 
<p id="datei"></p>

<script >
  
  setInterval(mytime, 1000);
  function mytime() {
    var d = new Date();
    var didi = d.toLocaleTimeString();
    let realdate = (document.getElementById("datei").innerHTML = didi);
  }
</script>
</center>
 <div class="about">
 <p>Welcome to H&B Barbershop! We are dedicated to providing exceptional grooming services to our clients. Our team of skilled barbers ensures a personalized experience tailored to your style.</p>
            <p>At H&B, we believe that grooming goes beyond just haircuts. It's about confidence and making you feel your best. Our goal is to create an inviting atmosphere where you can relax and leave looking and feeling fantastic.</p>
            <p>Visit us and let our expertise redefine your grooming experience.</p>

 </div>
</body>
</html>







<?php

include("footer.php");
?>