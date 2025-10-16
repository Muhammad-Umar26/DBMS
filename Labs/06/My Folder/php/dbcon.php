<?php
try {
$server = "mysql:host=localhost;dbname=umar";
$user = "root";
$pass = "";
$pdo = new PDO($server, $user, $pass);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
echo "connected successfully";

}
catch(PDOException $e) {
    echo "error". $e->getMessage();
}
?>