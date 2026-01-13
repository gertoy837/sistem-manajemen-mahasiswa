<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - UniManage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #4a6cf7;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            max-width: 400px;
            width: 100%;
        }
        .login-header {
            background-color: #4a6cf7;
            padding: 2rem;
            text-align: center;
        }
        .login-body { padding: 2rem; }
        .btn-login {
            background-color: #4a6cf7;
            border: none;
            padding: 0.75rem;
            font-weight: 600;
        }
        .btn-login:hover { background-color: #3d5bd9; }
        .form-control:focus {
            border-color: #4a6cf7;
            box-shadow: 0 0 0 0.2rem rgba(74, 108, 247, 0.25);
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="login-header">
            <i class="fas fa-graduation-cap text-white fa-3x mb-3"></i>
            <h4 class="text-white mb-0">UniManage</h4>
            <p class="text-white-50 mb-0">Sistem Manajemen Mahasiswa</p>
        </div>
        <div class="login-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label"><i class="fas fa-user me-2 text-secondary"></i>Username</label>
                    <input type="text" class="form-control form-control-lg" id="username" name="username" placeholder="Masukkan username" required>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label"><i class="fas fa-lock me-2 text-secondary"></i>Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Masukkan password" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()">
                            <i id="toggleIcon" class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn btn-login btn-lg w-100 text-white">
                    <i class="fas fa-sign-in-alt me-2"></i>Masuk
                </button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword() {
            const pwd = document.getElementById('password');
            const icon = document.getElementById('toggleIcon');
            if (pwd.type === 'password') {
                pwd.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                pwd.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
    </script>
</body>
</html>
