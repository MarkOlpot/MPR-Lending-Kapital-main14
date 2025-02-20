<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/index.css">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,opsz,wght@0,8..60,200..900;1,8..60,200..900&display=swap"
        rel="stylesheet">

    <!-- SweetAlert2 -->
    <script src="node_modules/sweetalert2/dist/sweetalert2.all.min.js"></script>
    <title>Log-in</title>
</head>

<body>
    <div class="login-container">
        <div class="logo-container">
            <img src="images/logo2.png" class="logo">
        </div>
        <div class="form-container">
            <h1>Log-in</h1>
            <form action="" method="post" class="login-form" id="loginForm">
                <label for="email" class="strong">Email</label>
                <br>
                <input type="email" name="email" id="email" placeholder="Please enter your email" required><br><br>
                <label for="password" class="strong">Password</label>
                <br>
                <input type="password" name="password" id="password" placeholder="Please enter your password" required>
                <button type="submit" name="login" class="login-button">Log-in</button>

                <div class="signup-container">
                    <p>Don't have an account? <a href="signup.php">Signup!</a></p>
                    <p>sample</p>
                </div>
        </div>
        </form>
    </div>
    <script>

        document.getElementById('loginForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const formData = new FormData(this);
            fetch('scripts/AJAX/login.php', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        Swal.fire({
                            title: 'Login Successful',
                            text: 'Redirecting to dashboard...',
                            icon: 'success',
                            timer: 2000,
                            confirmButtonText: 'OK'
                        }).then(() => {
                            // Redirect to dashboard page
                            window.location.href = 'dashboard.php';
                        });
                    } else {
                        Swal.fire({
                            title: 'Error',
                            text: data.message,
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                })
                .catch(error => {
                    Swal.fire({
                        title: 'Error',
                        text: 'An error occurred. Please try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                });
        });
    </script>
</body>

</html>