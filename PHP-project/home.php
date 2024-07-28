<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="home.css">
    <title>Document</title>
</head>
<body>
    <center>
<img src="./img/h_b.jpg"  style="width: 60%; height:370px; " >
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
<?php
include("header.php");
?>
<img src="./img/barbershop-logo.jpg"  style="width: 500px; height:500px; background-color:antiquewhite; margin-left:60%;margin-top:250px; ">

 
<h3 style=" font-size:30px; margin-top:-52%; width: 500px; color:aliceblue; ">
In Hindu tradition, from birth, hair is associated with less positive aspects of or qualities from past lives.[1] Thus at the time of the shave, the child is freshly shaven to signify freedom from the past and moving into the future.[2] It is also said that the shaving of the hair stimulates proper growth of the brain and nerves, and that the sikha, a tuft at the crown of the head, protects the memory.[2]

Hindus practice a variety of rituals from birth to death. Collectively these are known as saṃskāras, meaning rites of purification, and are believed to make the body pure and fit for worship. A boy's first haircut, known as choula or mundan, is one such samskara and is considered an event of great auspiciousness.[3] The lawbooks or smritis prescribe that a boy must have his haircut in his first or third year, though when a family does it varies in practice.[4] A girl's first haircut typically occurs at eleven months of age.[1]

While complete tonsure is common, some Hindus prefer to leave some hair on the head, distinguishing this rite from the inauspicious tonsure that occurs upon the death of a parent. Those that practice complete tonsure generally ritually offer the hair to their family deity. Many travel to temples such as the famed Tirumala Venkateswara Temple of Lord Vishnu to perform this ceremony.
</h3>
 
<?php

include("footer.php");
?>
</body>
</html>