<?php
include("dbcon.php");
$categoryName = $categoryDes = $categoryImageName = "" ;
$categoryNameErr = $categoryDesErr = $categoryImageNameErr = "" ;
if(isset($_POST['addCategory'])){
    $categoryName = $_POST['cName'];
    $categoryDes = $_POST['cDes'];
    $categoryImageName = $_FILES['cImage']['name'];
    $categoryImageTmpName = $_FILES['cImage']['tmp_name'];
    $destination = "images/".$categoryImageName ;
    $extension = pathinfo($categoryImageName , PATHINFO_EXTENSION);//example.pdf ->pdf
    if(empty($categoryName)){
            $categoryNameErr = "category Name is Required";
    }
    if(empty($categoryDes)){
        $categoryDesErr = "Category Description is Required";
    }
    if(empty($categoryImageName)){
            $categoryImageNameErr = "Category Image is Requried";
    }
    else{
        $allowedExtensionArray = ["png","svg","jpg" ,"jpeg","webp"];
        if(!in_array($extension,$allowedExtensionArray)){
            $categoryImageNameErr = "Invalid Extension";
        }
    }
    if(empty($categoryNameErr) && empty($categoryImageNameErr) && empty($categoryDesErr)){
             if(move_uploaded_file($categoryImageTmpName,$destination)){
                $query = $pdo->prepare("insert into categories (name , des , image) values (:cName , :cDes ,:cImage)");
                $query->bindParam("cName",$categoryName);
                $query->bindParam("cDes",$categoryDes);
                $query->bindParam("cImage",$categoryImageName);
                $query->execute();
                echo "<script>alert('category added successfully');location.assign('select.php')</script>";
             }   
    }
}

// update category wORK
if(isset($_POST['updateCategory'])){
    $categoryName = $_POST['cName'];
    $categoryDes = $_POST['cDes'];
    $categoryId = $_GET['cId'];
    $query = $pdo->prepare('update categories set name = :cName , des = :cDes where id = :cId');
    if(!empty($_FILES['cImage']['name'])) {
        $categoryImageName = $_FILES['cImage']['name'];
        $categoryImageTmpName = $_FILES['cImage']['tmp_name'];
        $destination = "images/".$categoryImagename;
        $extension = pathinfo($categoryImageName, PATHINFO_EXTENSION);
        if(move_uploaded_file($categoryImageTmpName, $destination)) {
            $query = $pdo->prepare("update categories set name = :cName , des = :cDes , image = :cImage where id = :cId");
            $query->bindParam("cImage",$categoryImageName);
        }
        $query->bindParam("cId", $categoryId);
        $query->bindParam("cName", $categoryName);
        $query->bindParam("cDes", $categoryDes);
        $query->execute();
        echo "<script>alert('Category Updated');location.assign('select.php')</script>";
    }
}

if(isset(($_GET['catId']))) {
    $categoryId = $_GET['catId'];
    $query = $pdo->prepare('delete from categories where id = :catId');
    $query->bindParam("catId", $categoryId);
    $query->execute();
    echo "<script>alert('Category Deleted');location.assign('select.php')</script>";
}
?>