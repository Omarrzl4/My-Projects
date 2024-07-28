<?php
try{
$conn=mysqli_connect("localhost","root","","h&b");
}

catch(mysqli_sql_exception){
echo"Not Connected";
}


?>