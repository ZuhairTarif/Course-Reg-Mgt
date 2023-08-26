<?php
require "../model/faculty-list.php";
$facultyList = fetchFacultyList();
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="./img/favicon.png" type="image/png">
    <title>AIUB Portal</title>
</head>
<body>
    

    <div class="manage-user-container">
        <h2 class="admin-form-title">Faculty List</h2>
        <div class="table-wrapper">
            <?php if ($facultyList !== false) : ?>
                <table class="manage-users" id="users-table">
                    <tr>
                        <th>Course Id</th>
                        <th>Class Info</th>
                        <th>Assigned Faculty</th>
                    </tr>
                    <?php foreach ($facultyList as $faculty) : ?>
                        <tr>
                            <td><?= $faculty['COURSE_ID'] ?></td>
                            <td><?= $faculty['CLASS_INFO'] ?></td>
                            <td><?= $faculty['ASSIGNED_FACULTY'] ?></td>
                        </tr>
                    <?php endforeach; ?>
                </table>
            <?php else : ?>
                <p>An error occurred while fetching faculty data.</p>
            <?php endif; ?>
        </div>
    
    <div class="center">
            <button class="button" onclick="goBack()">Back</button>
        </div>
    

    <!-- JavaScript function to go back when the button is clicked -->
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
    </div>
    </div>
</body>
</html>
