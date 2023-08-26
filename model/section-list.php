<?php
require_once 'database-config.php';
require_once '../model/protection.php';
verifyLoggedIn();
verifyNotStudent();

function fetchSectionList()
{
    $query = "SELECT * from total_sections";

    try {
        $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
        $stid = oci_parse($conn, $query);
        oci_execute($stid);

        $sections = array();

        while (($row = oci_fetch_assoc($stid)) != false) {
            $sections[] = $row;
        }
        return $sections;
    } catch (Exception $ex) {
        // Handle the database error appropriately
        return false;
    }
}
?>
