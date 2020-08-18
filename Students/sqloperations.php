<?php

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "testdb";
    $table = "students"; 
 
    //This command came from the app, you will see it soon 
    $action = $_POST["action"];
     
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    } 
    // If connection is OK...
 
    // For table creation, temporal table maybe for shopping cart and so on 
    if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table ( 
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            first_name VARCHAR(50) NOT NULL,
            last_name1 VARCHAR(50) NOT NULL,
            last_name2 VARCHAR(50) NOT NULL,
            email VARCHAR(50) NOT NULL,
            phone VARCHAR(15) NOT NULL,
            matricula VARCHAR(50) NOT NULL,
            foto LONGBLOB NOT NULL
            )";
 
        if($conn->query($sql) === TRUE){
            // send back success message
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    //SELECT ALL THE DATA
    if("SELECT_TABLE" == $action){
         $database_data = array();         
         $sql = "SELECT 
            id ,
            first_name,
            last_name1,
            last_name2,
            email,
            phone,
            matricula,
            foto
            FROM $table ORDER BY id DESC";
            $result = $conn->query($sql);
            
        if($result->num_rows>0){
            while($row = $result->fetch_assoc()){
                $database_data[]=$row;
            }
            echo json_encode($database_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    //SAVE DATA
    if("INSERT_DATA" == $action){
       $first_name = $_POST["first_name"];
       $last_name1 = $_POST["last_name1"];
       $last_name2 = $_POST["last_name2"];
       $email = $_POST["email"];
       $phone = $_POST["phone"];
       $matricula = $_POST["matricula"];
       $foto = $_POST['foto'];

       $sql = "INSERT INTO $table (first_name,last_name1,last_name2,email,phone,matricula,foto)VALUES('$first_name','$last_name1','$last_name2','$email','$phone','$matricula','$foto')";
       $result = $conn->query($sql);
       echo "success";            
       echo "$foto";
       $conn->close();
       return;
   }

   //UPDATE DATA
   if("UPDATE_DATA" == $action){
        $id_alumno = $_POST["id_alumno"]; //ES OTRO ID DIFERENTE AL AUTOINCREMENTE
        $first_name = $_POST["first_name"];
        $last_name1 = $_POST["last_name1"];
        $last_name2 = $_POST["last_name2"];
        $email = $_POST["email"];
        $phone = $_POST["phone"];
        $matricula = $_POST["matricula"];
        $foto = $_POST["foto"];
        $sql = "UPDATE $table SET 
        first_name = '$first_name',
        last_name1 = '$last_name1',
        last_name2 = '$last_name2',
        email = '$email',
        phone = '$phone',
        matricula = '$matricula',
        foto = '$foto'
        WHERE id = '$id_alumno'";
        if($conn->query($sql) === TRUE){
            echo "succes";
        }else{
            echo "error";
        }
        $conn->close();
        return;
   }

   //DELETE DATA
   if("DELETE_DATA" == $action){
       $id_alumno = $_POST['id_alumno'];
       $sql = "DELETE FROM $table WHERE id = $id_alumno";
       if($conn->query($sql)){
           echo "succes";
       }else{
           echo "error";
       }
       $conn->close();
       return;
   }

?>