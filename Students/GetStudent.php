<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "testdb";

// Create connection
$conn = new mysqli($servername, $username, $password,$dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM students";
$result = $conn->query($sql);
$response = array();

if($result->num_rows > 0){
    while ($row = $result->fetch_assoc()){
        array_push($response,$row);
    }
}

$conn->close();
header('Content-Type: application/json');
echo json_encode($response);
?>