<?php
require_once 'database-config.php';

function deleteCourse($courseId)
{
    $query = "DELETE FROM Course_id WHERE Course_id = :courseId";

    try {
        $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
        $stid = oci_parse($conn, $query);
        oci_bind_by_name($stid, ':courseId', $courseId);
        oci_execute($stid);
        oci_commit($conn);
        return true;
    } catch (Exception $ex) {
        return false;
    }
}
?>
