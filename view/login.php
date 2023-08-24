<?php require "../model/login.php" ?>
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
<div class="login-form-container center-screen">
    <form method="POST">
        <h2 class="login-form-title">Portal Login</h2>

        <fieldset>
            <div>
                <label for="email">Email</label>
                <input autofocus class="form-input-box" id="email" name="email"
                       placeholder="Enter your email here" type="text"
                       value="<?php echo isset($_POST['email']) ? $_POST['email'] : '' ?>">
            </div>
            <div>
                <label for="password">Password</label>
                <input id="password" name="password" autocomplete="on" class="form-input-box"
                       placeholder="Enter your password here" type="password"
                       value="<?php echo isset($_POST['password']) ? $_POST['password'] : '' ?>">
            </div>
        </fieldset>

        <div>
            <div class="center-text">
                <p id="prompt-message">
                    <?php
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        if (!login()) {
                            echo '<span class="error-message">Please fill out all the fields properly</span>';
                        }
                    } elseif (isset($_GET['failed']))
                        echo '<span class="error-message">Invalid Email or Password</span>'
                    ?>
                </p>
            </div>
            <br/>
            <div class="center">
                <input id="form-submit" type="submit" class="button"
                       value="Login">
            </div>
        </div>
    </form>
</div>
</body>
</html>