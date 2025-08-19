<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Pahana Edu Online Billing System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            text-align: center;
            transition: transform 0.3s ease;
            max-height: 90vh;
            overflow-y: auto;
        }

        .signup-container:hover {
            transform: translateY(-5px);
        }

        .logo {
            margin-bottom: 30px;
        }

        .logo h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 5px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .logo p {
            color: #666;
            font-size: 0.9rem;
        }

        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
            flex: 1;
        }

        .form-group.full-width {
            flex: 1 1 100%;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }

        .signup-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .signup-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .signup-btn:active {
            transform: translateY(0);
        }

        .login-link {
            color: #666;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .error-message {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.2);
            color: #dc3545;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            display: none;
            text-align: left;
        }

        .success-message {
            background: rgba(40, 167, 69, 0.1);
            border: 1px solid rgba(40, 167, 69, 0.2);
            color: #28a745;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            display: none;
        }

        .password-strength {
            margin-top: 5px;
            font-size: 0.8rem;
            color: #666;
        }

        .strength-bar {
            height: 4px;
            background: #e1e8ed;
            border-radius: 2px;
            margin-top: 5px;
            overflow: hidden;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }

        .required {
            color: #dc3545;
        }

        @media (max-width: 600px) {
            .signup-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .logo h1 {
                font-size: 2rem;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="logo">
            <h1>Pahana Edu</h1>
            <p>Create Your Account</p>
        </div>

        <div class="error-message" id="errorMessage"></div>
        <div class="success-message" id="successMessage"></div>

        <form id="signupForm" method="post" action="signup">
            <div class="form-row">
            
            <div class="form-group">
                <label for="accountNumber">Account Number (from cashier/admin) <span style="color:red">*</span></label>
                <input type="text" id="accountNumber" name="accountNumber" required 
                       placeholder="Enter your Account No e.g. PEAC01">
            </div>
            
                <div class="form-group">
                    <label for="firstName">First Name <span class="required">*</span></label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name <span class="required">*</span></label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
            </div>

            <div class="form-group full-width">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group full-width">
                <label for="username">Username <span class="required">*</span></label>
                <input type="text" id="username" name="username" required minlength="3">
                <small style="color: #666; font-size: 0.8rem;">At least 3 characters, letters and numbers only</small>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password" required minlength="6">
                    <div class="password-strength">
                        <div class="strength-bar">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <span id="strengthText">Password strength: Weak</span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
            </div>

            <div class="form-group full-width">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" placeholder="+94 XX XXX XXXX">
            </div>

            <div class="form-group full-width">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Street address, City">
            </div>

            

            <button type="submit" class="signup-btn">Create Account</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>

    <script>
        // Password strength checker
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthFill = document.getElementById('strengthFill');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            let strengthLabel = 'Weak';
            let color = '#dc3545';
            
            if (password.length >= 6) strength += 1;
            if (password.match(/[a-z]/)) strength += 1;
            if (password.match(/[A-Z]/)) strength += 1;
            if (password.match(/[0-9]/)) strength += 1;
            if (password.match(/[^a-zA-Z0-9]/)) strength += 1;
            
            const width = (strength / 5) * 100;
            
            if (strength >= 4) {
                strengthLabel = 'Strong';
                color = '#28a745';
            } else if (strength >= 2) {
                strengthLabel = 'Medium';
                color = '#ffc107';
            }
            
            strengthFill.style.width = width + '%';
            strengthFill.style.backgroundColor = color;
            strengthText.textContent = `Password strength: ${strengthLabel}`;
            strengthText.style.color = color;
        });

        // Form validation
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const formData = new FormData(this);
            const data = Object.fromEntries(formData);
            const errorDiv = document.getElementById('errorMessage');
            
            // Clear previous messages
            errorDiv.style.display = 'none';
            errorDiv.innerHTML = '';
            
            const errors = [];
            
            // Required field validation
            if (!data.firstName.trim()) errors.push('First name is required.');
            if (!data.lastName.trim()) errors.push('Last name is required.');
            if (!data.email.trim()) errors.push('Email is required.');
            if (!data.username.trim()) errors.push('Username is required.');
            if (!data.password.trim()) errors.push('Password is required.');
            if (!data.confirmPassword.trim()) errors.push('Password confirmation is required.');
          
            
            // Format validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (data.email && !emailRegex.test(data.email)) {
                errors.push('Please enter a valid email address.');
            }
            
            const usernameRegex = /^[a-zA-Z0-9]+$/;
            if (data.username && !usernameRegex.test(data.username)) {
                errors.push('Username can only contain letters and numbers.');
            }
            
            if (data.username && data.username.length < 3) {
                errors.push('Username must be at least 3 characters long.');
            }
            
            if (data.password && data.password.length < 6) {
                errors.push('Password must be at least 6 characters long.');
            }
            
            if (data.password !== data.confirmPassword) {
                errors.push('Passwords do not match.');
            }
            
            const phoneRegex = /^(\+94|0)?[0-9]{9}$/;
            if (data.phone && data.phone.trim() && !phoneRegex.test(data.phone.replace(/\s/g, ''))) {
                errors.push('Please enter a valid Sri Lankan phone number.');
            }
            
            if (errors.length > 0) {
                showErrors(errors);
                e.preventDefault();
                return;
            }
        });

        function showErrors(errors) {
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.innerHTML = '<strong>Please fix the following errors:</strong><br>' + 
                               errors.map(error => '• ' + error).join('<br>');
            errorDiv.style.display = 'block';
            
            // Scroll to top to show errors
            errorDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
            
            // Add shake animation
            errorDiv.style.animation = 'shake 0.5s ease-in-out';
            setTimeout(() => {
                errorDiv.style.animation = '';
            }, 500);
        }

        function showSuccess(message) {
            const successDiv = document.getElementById('successMessage');
            successDiv.textContent = message;
            successDiv.style.display = 'block';
        }

        // Check for URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');
        const success = urlParams.get('success');
        
        if (error) {
            showErrors([decodeURIComponent(error)]);
        }
        
        if (success) {
            showSuccess(decodeURIComponent(success));
        }

        // Username availability check (mock function)
        let usernameTimeout;
        document.getElementById('username').addEventListener('input', function() {
            clearTimeout(usernameTimeout);
            const username = this.value.trim();
            
            if (username.length >= 3) {
                usernameTimeout = setTimeout(() => {
                    // Here you would make an AJAX call to check username availability
                    // For now, just validate format
                    const usernameRegex = /^[a-zA-Z0-9]+$/;
                    if (!usernameRegex.test(username)) {
                        this.setCustomValidity('Username can only contain letters and numbers.');
                    } else {
                        this.setCustomValidity('');
                    }
                }, 500);
            }
        });

        // Real-time password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match.');
            } else {
                this.setCustomValidity('');
            }
        });

        // Add CSS for shake animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>