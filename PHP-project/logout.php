<?php

unset( $_SESSION['user']);
unset( $_SESSION['pass']);

header("Location:signin.php");
?>
