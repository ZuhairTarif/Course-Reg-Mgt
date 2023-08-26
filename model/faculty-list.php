<?php
require_once 'database-config.php';
require_once '../model/protection.php';
verifyLoggedIn();
verifyNotFaculty();

function fetchFacultyList()
{
    $query = "SELECT Course_id.Course_id, Course_id.Class_info, Dept.Assigned_faculty
              FROM Course_id
              JOIN Dept ON Course_id.Course_d = Dept.Course_d";

    try {
        $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
        $stid = oci_parse($conn, $query);
        oci_execute($stid);

        $faculties = array();

        while (($row = oci_fetch_assoc($stid)) != false) {
            $faculties[] = $row;
        }
        return $faculties;
    } catch (Exception $ex) {
        // Handle the database error appropriately
        return false;
    }
}
?>
