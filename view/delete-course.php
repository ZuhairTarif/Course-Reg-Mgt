<?php
require_once '../model/database-config.php';
require_once '../model/delete-course.php';

// Fetch the list of courses from the database
$query = "SELECT Course_id, Class_info FROM Course_id";
$conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
$stid = oci_parse($conn, $query);
oci_execute($stid);

$courses = array();
while (($row = oci_fetch_assoc($stid)) != false) {
    $courses[] = $row;
}

$message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_course'])) {
    $courseId = $_POST['delete_course'];

    if (deleteCourse($courseId)) {
        $message = "Course deleted successfully.";
    } else {
        $message = "An error occurred while deleting the course.";
    }
}
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <title>Delete Course</title>
</head>
<body>
    <div class="manage-user-container">
        <h1 class="admin-form-title">Delete Course</h1>
    

    <div class="table-wrapper">
        <p><?php echo $message; ?></p>
        <table class="manage-users" id="users-table">
            <tr>
                <th>Course ID</th>
                <th>Class Info</th>
                <th>Action</th>
            </tr>
            <?php foreach ($courses as $course) : ?>
                <tr>
                    <td><?php echo $course['COURSE_ID']; ?></td>
                    <td><?php echo $course['CLASS_INFO']; ?></td>
                    <td>
                        <form method="post" action="">
                            <input type="hidden" name="delete_course" value="<?php echo $course['COURSE_ID']; ?>">
                            <button type="submit" class="button1">Delete</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
        <div class="center">
            <button class="button" onclick="goBack()">Back</button>
        </div>
    </div>
    </div>

    <!-- JavaScript function to go back when the button is clicked -->
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
    </div>
</body>
</html>
