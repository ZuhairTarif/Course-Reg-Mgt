<?php
require_once '../model/protection.php';
verifyLoggedIn();
require_once 'database-config.php';

function courseAdd()
{
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $courseinfo = $_POST['courseinfo'];
        $coursetime = $_POST['coursetime'];
        $section = $_POST['section'];

        $query = "INSERT INTO Course (Course_info, Course_time, SECTION) VALUES (:courseinfo, :coursetime, :section)";
        try {
            $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);

            $stid = oci_parse($conn, $query);

            oci_bind_by_name($stid, ":courseinfo", $courseinfo);
            oci_bind_by_name($stid, ":coursetime", $coursetime);
            oci_bind_by_name($stid, ":section", $section);

            $result = oci_execute($stid);

            if ($result) {
                header("Location: ../view/course-add.php?success");
                exit();
            } else {
                header("Location: ../view/database-error.php");
                exit();
            }
        } catch (Exception $ex) {
            header("Location: ../view/database-error.php");
            exit();
        }
    }

    return false;
}
?>
