<?php
include("dbcon.php");
$categoryName = $categoryDes = $categoryImageName = "";
$categoryNameErr = $categoryDesErr = $categoryImageNameErr = "";
if(isset($_POST["addCategory"])) {
    $categoryName = $_POST["cname"];
    $categoryDes = $_POST["cdes"];
    $categoryImageName = $_FILES['cimage']['name'];
    $categoryImageTmpName = $_FILES['cimage']['tmp_name'];
    $destination = "images/".$categoryImageName;
    $extension = pathinfo($categoryImageName, PATHINFO_EXTENSION);
    if(empty($categoryName)) {
        $categoryNameErr = "Category Name is required";
    }

    if(empty($categoryDes)) {
        $categoryDesErr = "Category Description is required";
    }

    if(empty($categoryImageName)) {
        $categoryImageNameErr = "Category Image is required";
    } else {
        $allowedExtensionArray = ["png", "svg", "jpg", "jpeg", "webp"];
        if(!in_array($extension, $allowedExtensionArray)) {
            $categoryImageNameErr = "Invalid Extension";
        }
    }

    if(empty($categoryNameErr) && empty($categoryImageNameErr) && empty($categoryDesErr)) {
        if(move_uploaded_file($categoryImageTmpName, $destination)) {
            $query = $pdo->prepare("insert into categories (name, des, image) values (:cName, :cDes, :cImage)");
            $query->bindParam("cName", $categoryName);
            $query->bindParam("cDes", $categoryDes);
            $query->bindParam("cImage", $categoryImageName);
            $query->execute();
            echo "<script> alert('category added successfully');location.assign('select.php')</script>";
        }
    }
}
?>