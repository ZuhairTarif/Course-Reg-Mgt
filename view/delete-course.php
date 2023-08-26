<?php
require_once '../model/database-config.php';
require_once '../model/delete-course.php';


$query = "SELECT Course_info, Course_time, SECTION FROM Course";
$conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
$stid = oci_parse($conn, $query);
oci_execute($stid);

$courses = array();
while (($row = oci_fetch_assoc($stid)) != false) {
    $courses[] = $row;
}

$message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_course'])) {
    $courseInfo = $_POST['delete_course'];

    if (deleteCourse($courseInfo)) {
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
    <title>Delete Course</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="./img/favicon.png" type="image/png">

</head>
<body>
    <div class="manage-user-container">
        <h1 class="admin-form-title">Delete Course</h1>
        <div class="table-wrapper">
            <p><?php echo $message; ?></p>
            <table class="manage-users" id="users-table">
                <tr>
                    <th>Course Info</th>
                    <th>Course Time</th>
                    <th>Section</th>
                    <th>Action</th>
                </tr>
                <?php foreach ($courses as $course) : ?>
                    <tr>
                        <td><?php echo $course['COURSE_INFO']; ?></td>
                        <td><?php echo $course['COURSE_TIME']; ?></td>
                        <td><?php echo $course['SECTION']; ?></td>
                        <td>
                            <form method="post" action="">
                                <input type="hidden" name="delete_course" value="<?php echo $course['COURSE_INFO']; ?>">
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

    
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
