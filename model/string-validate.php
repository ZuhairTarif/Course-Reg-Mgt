<?php

function checkLength($string, $minLength = 3, $maxLength = 16)
{
    $length = strlen($string);
    return $length > $minLength && $length < $maxLength;
}

function removeWhitespaces($string)
{
    return preg_replace('/\s+/', '', $string);
}

function validatePhone($phone)
{
    $regex = "/^(?:(?:\+|0{0,2})91(\s*[\ -]\s*)?|[0]?)?[456789]\d{9}|(\d[ -]?){10}\d$/";
    return preg_match($regex, $phone);
}