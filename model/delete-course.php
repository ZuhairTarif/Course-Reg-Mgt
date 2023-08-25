<?php
require_once '../model/protection.php';
verifyLoggedIn();
require_once 'database-config.php';

function deleteCourse($courseInfo)
{
    $query = "DELETE FROM Course WHERE Course_info = :courseInfo";

    try {
        $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
        $stid = oci_parse($conn, $query);
        oci_bind_by_name($stid, ':courseInfo', $courseInfo);
        oci_execute($stid);
        oci_commit($conn);
        return true;
    } catch (Exception $ex) {
        return false;
    }
}
?>
