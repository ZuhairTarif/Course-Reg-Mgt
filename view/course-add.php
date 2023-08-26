<?php require "../model/course-add.php" ?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="./img/favicon.png" type="image/png">
    <title>Course Add</title>
</head>
<body>
<div class="form-container center-screen">
    <form method="POST">
        <h2 class="login-form-title">Add Course</h2>
        <fieldset>
            <div>
                <div>
                    <label class="form-label" for="courseinfo">Course Info</label>
                    <input autofocus class="form-input-box" id="courseinfo" name="courseinfo"
                           placeholder="Enter Course Info type "text"
                           value="<?php echo isset($_POST['courseinfo']) ? $_POST['courseinfo'] : '' ?>">
                </div>
                <div>
                    <label class="form-label" for="coursetime">Course Time</label>
                    <input autofocus class="form-input-box" id="coursetime" name="coursetime"
                           placeholder="Enter Course Time type "text"
                           value="<?php echo isset($_POST['coursetime']) ? $_POST['coursetime'] : '' ?>">
                </div>
                <div>
                    <label class="form-label" for="section">Section</label>
                    <input autofocus class="form-input-box" id="section" name="section"
                           placeholder="Enter Section type "text"
                           value="<?php echo isset($_POST['section']) ? $_POST['section'] : '' ?>">
                </div>
                
            </div>
        </fieldset>
        <div>
            <div class="center-text">
                <p id="prompt-message">
                    <?php
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        if (!courseAdd()) {
                            echo '<span class="error-message">Please fill out all the fields properly</span>';
                        }
                    }

                    if (isset($_GET['success']))
                        echo '<span class="success">Course Added Successfully</span>';
                    ?>
                </p>
            </div>
            <div class="center">
                <input id="form-submit" type="submit" class="button"
                       value="Add">
            </div>
        </div>
    </form>
    </div>
    <div class="center">
                <button class="button1" onclick="goBack()">Back</button>
    </div>
    


    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>