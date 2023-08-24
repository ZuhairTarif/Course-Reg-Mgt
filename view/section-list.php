<?php
require "../model/section-list.php";
$sectionList = fetchSectionList();
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <title>AIUB Portal</title>
</head>
<body>
    

    <div class="manage-user-container">
        <h2 class="admin-form-title">Section List</h2>
        <div class="table-wrapper">
            <?php if ($sectionList !== false) : ?>
                <table class="manage-users" id="users-table">
                    <tr>
                        <th>Course Info</th>
                        <th>Number of Sections</th>
                        
                    </tr>
                    <?php foreach ($sectionList as $section) : ?>
                        <tr>
                            <td><?= $section['COURSE_INFO'] ?></td>
                            <td><?= $section['NUM_SECTIONS'] ?></td>
                            
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
