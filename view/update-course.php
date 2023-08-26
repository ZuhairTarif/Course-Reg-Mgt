<?php
require_once '../model/database-config.php';
require_once '../model/update-course.php';

$message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $courseInfo = $_POST['courseinfo'];
    $newCourseTime = $_POST['newcoursetime'];
    $newSection = $_POST['newsection'];

    if (updateCourse($courseInfo, $newCourseTime, $newSection)) {
        $message = "Course updated successfully.";
    } else {
        $message = "An error occurred while updating the course.";
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
    <title>Update Course</title>
</head>
<body>
    <div class="form-container center-screen">
        <form method="POST">
            <h2 class="login-form-title">Update Course</h2>
            <fieldset>
                <div>
                    <div>
                        <label class="form-label" for="courseinfo">Course Info</label>
                        <input autofocus class="form-input-box" id="courseinfo" name="courseinfo"
                               placeholder="Enter Course Info" type="text">
                    </div>
                    <div>
                        <label class="form-label" for="newcoursetime">New Course Time</label>
                        <input autofocus class="form-input-box" id="newcoursetime" name="newcoursetime"
                               placeholder="Enter New Course Time" type="text">
                    </div>
                    <div>
                        <label class="form-label" for="newsection">New Section</label>
                        <input autofocus class="form-input-box" id="newsection" name="newsection"
                               placeholder="Enter New Section" type="text">
                    </div>
                </div>
            </fieldset>
            <div class="center-text">
                <p id="prompt-message"><?php echo $message; ?></p>
            </div>
            <div class="center">
                <input id="form-submit" type="submit" class="button" value="Update">
            </div>
        </form>
        <br>
        <div class="center">
            <button class="button1" onclick="goBack()">Back</button>
        </div>
    </div>

    <!-- JavaScript function to go back when the button is clicked -->
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
