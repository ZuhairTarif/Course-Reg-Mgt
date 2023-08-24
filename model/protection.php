<?php
session_start();

// Used when a user must be logged in
function verifyLoggedIn()
{
    if (!isset($_SESSION['user_authenticated'])) {
        header("Location: ../view/login.php");
        die();
    }
}

// Used when a user must not be logged in
function verifyNotLoggedIn()
{
    if (isset($_SESSION['user_authenticated'])) {
        header("Location: ../view/login.php"); 
        die();
    }
}

// Used when a user must not be a student
function verifyNotStudent()
{
    if ($_SESSION['user_type'] === 'Student') {
        header("Location: ../view/access-denied.php"); 
        die();
    }
}

// Used when a user must not be a faculty
function verifyNotFaculty()
{
    if ($_SESSION['user_type'] === 'Faculty') {
        header("Location: ../view/access-denied.php"); 
        die();
    }
}
?>
