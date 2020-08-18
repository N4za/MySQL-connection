<?php
include 'testconnection.php';

// Creating connection
$conn = new mysqli($servername, $username, $password,$dbname);
 
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
} 

	// Creating SQL command to fetch all records from students Table.
	$sql = "SELECT * FROM students";
	 
	$result = $conn->query($sql);
 
if ($result->num_rows > 0) {
 
	 while($row[] = $result->fetch_assoc()) {
	 
	 $item = $row;
	 
	 $json = json_encode($item, JSON_NUMERIC_CHECK);
	 
 }
 
} else {
	echo "No Data Found.";
}
echo $json;
$conn->close();
 
?>