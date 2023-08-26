<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../view/css/style.css">
    <link rel="icon" href="./img/favicon.png" type="image/png">
    <title>Student Dashboard</title>
</head>
<body>
<header>
    
    <nav>
        <ul class="nav-links">
            <li><a href="./course-add.php">Add Course</a></li>
            <li><a href="./delete-course.php">Delete Course</a></li>
            <li><a href="./faculty-list.php">Faculty List</a></li>
            <li><a href="../model/logout.php">Logout</a></li>
        </ul>
    </nav>
</header>

<div class="center-screen home-form-container" style="text-align: center">
    <h1 style="color: white">
    <?php
            // Retrieve the email from the query parameter
            $studentUsername = $_GET['username'];
            echo "Welcome " . htmlspecialchars($studentUsername);
    ?>
            </h1><br>
    <h2 class="success">Login Successful</h2><br>
    
</div>

<footer>
   Developed by Zuhair Ahmed, 2023. All rights reserved.
</footer>
</body>
</html>
