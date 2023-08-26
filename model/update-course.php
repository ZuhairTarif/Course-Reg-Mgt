<?php
require_once 'database-config.php';
require_once '../model/protection.php';
verifyLoggedIn();
verifyNotStudent();

function updateCourse($courseInfo, $newCourseTime, $newSection)
{
    $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
    $query = "BEGIN
                update_course(:courseInfo, :newCourseTime, :newSection);
              END;";
              
    $stid = oci_parse($conn, $query);
    oci_bind_by_name($stid, ':courseInfo', $courseInfo);
    oci_bind_by_name($stid, ':newCourseTime', $newCourseTime);
    oci_bind_by_name($stid, ':newSection', $newSection);

    try {
        oci_execute($stid);
        oci_commit($conn);
        return true;
    } catch (Exception $ex) {
        oci_rollback($conn);
        return false;
    } finally {
        oci_free_statement($stid);
        oci_close($conn);
    }
}
?>
