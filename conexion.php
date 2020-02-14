<?php
$server = "localhost";
$username = "root";
$pass = "";
$dbname = "inventario";
$table = "conteo";

$action = $_POST["action"];

//Crear la Conexion
$conexion = new mysqli($server,$username,$pass,$dbname);

//Checar la Conexion
if($conexion->connect_error)
{
    die("Error en la Conexion" . $conexion->connect_error);
    return;
}

//Envio de Consultas a la App

//Creacion de la Tabla desde la App
if("CREATE_TABLE" == $action)
{
    $sql = "CREATE TABLE IF NOT EXISTS conteo (
        Clave VARCHAR(100) PRIMARY KEY NOT NULL,
        Nombre VARCHAR(100) NOT NULL,
        Zona VARCHAR(100) NOT NULL,
        Existencia VARCHAR(100) NOT NULL,
        Conteo VARCHAR(100) NOT NULL)";
    
    if($conexion->query($sql) == true)
    {
        echo "Success";
    }
    else
    {
        echo "Error";
    }
    $conexion->close();
    return;
}

//Obtener los Datos de la Tabla
if("GET_DATA" == $action)
{
    $db_data = array();
	$clave = $_POST['Clave'];
    $sql = "SELECT Clave,Nombre,Zona,Existencia,Conteo FROM $table WHERE Clave = '$clave'";
    $result = $conexion->query($sql);

    if($result->num_rows > 0)
    {
        while($row = $result->fetch_assoc())
        {
            $db_data[] = $row;
        }
        
        echo json_encode($db_data);
    }
    else
    {
        echo "Error";
    }

    $conexion->close();
    return;
}

if("GET_ALL" == $action)
{
    $db_data = array();
    $sql = "SELECT Clave,Nombre,Zona,Existencia,Conteo FROM $table";
    $result = $conexion->query($sql);

    if($result->num_rows > 0)
    {
        while($row = $result->fetch_assoc())
        {
            $db_data[] = $row;
        }
        
        echo json_encode($db_data);
    }
    else
    {
        echo "Error";
    }

    $conexion->close();
    return;
}

//Agregar Datos a la Tabla
if("ADD_PRODUCT" == $action)
{
    $clave = $_POST['Clave'];
    $nombre = $_POST['Nombre'];
    $zona = $_POST['Zona'];
    $existencia = $_POST['Existencia'];
    $conteo = $_POST['Conteo'];

    $sql = "INSERT INTO  $table (Clave,Nombre,Zona,Existencia,Conteo) VALUES('$clave','$nombre','$zona','$existencia','$conteo') ON DUPLICATE KEY UPDATE Nombre= '$nombre', Zona='$zona', Existencia='$existencia', Conteo='$conteo' ";
    $result = $conexion->query($sql);
    echo "Success";
    $conexion->close();
    return;
}
?>