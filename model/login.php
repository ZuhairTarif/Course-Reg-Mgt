<?php
session_start();
require_once 'database-config.php';

function login()
{
    $email = $_POST['email'];
    $password = $_POST['password'];

    if (removeWhitespaces($email) && removeWhitespaces($password)) {
        // Check if the user's email exists in the Student table
        $query = "SELECT Email FROM Student WHERE Email = :email";
        try {
            $conn = oci_connect(USERNAME, PASSWORD, CONNECTION_STRING);
            $stid = oci_parse($conn, $query);
            oci_bind_by_name($stid, ":email", $email);
            oci_execute($stid);

            if (oci_fetch($stid)) {
                // User is a student
                $table = 'Student';
            } else {
                // User is not a student, so check if the email exists in the Faculty table
                $query = "SELECT Email FROM Faculty WHERE Email = :email";
                $stid = oci_parse($conn, $query);
                oci_bind_by_name($stid, ":email", $email);
                oci_execute($stid);

                if (oci_fetch($stid)) {
                    // User is a faculty member
                    $table = 'Faculty';
                } else {
                    // Neither student nor faculty, show error
                    header("Location: ../view/login.php?failed");
                    die();
                }
            }

            $_SESSION['user_authenticated'] = true;
            $_SESSION['user_type'] = $table; 
            $_SESSION['username'] = $username;

            // Now that we know if it's a student or faculty, proceed with the login logic
            $query = "SELECT * FROM $table 
                      WHERE Email = :email 
                      AND Password = :password";

            $stid = oci_parse($conn, $query);
            oci_bind_by_name($stid, ":email", $email);
            oci_bind_by_name($stid, ":password", $password);
            oci_execute($stid);

            $ociResult = oci_fetch($stid);

            if ($ociResult) {
                // Retrieve the username from the database
                $query = "SELECT Username FROM $table WHERE Email = :email";
                $stid = oci_parse($conn, $query);
                oci_bind_by_name($stid, ":email", $email);
                oci_execute($stid);
                $row = oci_fetch_assoc($stid);
                $username = $row['USERNAME'];


                // Redirect based on detected table (student or faculty)
                if ($table === 'Student') {
                    header("Location: ../view/home-student.php?login=success&username=" . urlencode($username));
                } elseif ($table === 'Faculty') {
                    header("Location: ../view/home-faculty.php?login=success&username=" . urlencode($username));
                }
                die();
            } else {
                header("Location: ../view/login.php?failed");
                die();
            }
        } catch (Exception $ex) {
            header("Location: ../view/database-error.php");
            die();
        }
    }

    return false;
}

function removeWhitespaces($string)
{
    return preg_replace('/\s+/', '', $string);
}
?>
