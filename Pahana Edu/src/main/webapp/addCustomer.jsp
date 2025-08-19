<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Customer</title>
<style>
        /* Use the exact same styles as signup.jsp for consistency */
        /* Paste your signup.jsp CSS styles here or link externally */
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

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 600px;
            text-align: center;
            max-height: 90vh;
            overflow-y: auto;
        }

        .container:hover {
            transform: translateY(-5px);
            transition: transform 0.3s ease;
        }

        h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        p.subtitle {
            color: #666;
            font-size: 1rem;
            margin-bottom: 30px;
        }

        form {
            text-align: left;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.9rem;
        }

        input[type="text"], input[type="tel"], input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 0.95rem;
            background: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }

        input[type="text"]:focus, input[type="tel"]:focus, input[type="number"]:focus {
            outline: none;
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }

        .submit-btn {
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
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .error-message, .success-message {
            font-size: 0.9rem;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 8px;
            display: none;
            text-align: left;
        }

        .error-message {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        .success-message {
            background: rgba(40, 167, 69, 0.1);
            border: 1px solid rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .required {
            color: #dc3545;
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Add New Customer</h1>
    <p class="subtitle">Enter customer details below</p>

   <%-- Success Message --%>
    <% if(request.getAttribute("success") != null){ %>
        <div class="success-message" style="display:block;">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>

    <%-- Error Message --%>
    <% if(request.getAttribute("error") != null){ %>
        <div class="error-message" style="display:block;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form id="addCustomerForm" method="post" action="addCustomer">
        <div class="form-group">
            <label for="accountNumber">Account Number <span class="required">*</span></label>
            <input type="text" id="accountNumber" name="accountNumber"
                   value="<%= request.getAttribute("generatedAccount") != null ? request.getAttribute("generatedAccount") : "" %>"
                   readonly>
            
        </div>

        <div class="form-group">
            <label for="name">Customer Name <span class="required">*</span></label>
            <input type="text" id="name" name="name" required minlength="3">
        </div>

        <div class="form-group">
            <label for="address">Address <span class="required">*</span></label>
            <input type="text" id="address" name="address" required>
        </div>

        <div class="form-group">
            <label for="phone">Telephone Number <span class="required">*</span></label>
            <input type="tel" id="phone" name="phone" placeholder="+94 XX XXX XXXX"
                   required pattern="^(\+94[0-9]{9}|0[0-9]{9})$" title="Please enter a valid Sri Lankan phone number">
        </div>

        <div class="form-group">
            <label for="unitsConsumed">Units Consumed <span class="required">*</span></label>
            <input type="number" id="unitsConsumed" name="unitsConsumed" min="0" required>
        </div>

        <button type="submit" class="submit-btn">Add Customer</button>
    </form>
</div>

<script>

//Client-side validation
document.getElementById('addCustomerForm').addEventListener('submit', function(e) {
    const errors = [];
    const form = e.target;

    if (!form.name.value.trim()) errors.push('Customer name is required.');
    if (!form.address.value.trim()) errors.push('Address is required.');
    if (!form.phone.value.trim()) errors.push('Telephone number is required.');
    if (!form.unitsConsumed.value || form.unitsConsumed.value < 0) errors.push('Units Consumed must be zero or more.');

    if (errors.length > 0) {
        alert("Please fix the following errors:\n" + errors.join("\n")); // simple alert
        e.preventDefault();
    }
});
   /*const errorDiv = document.getElementById('errorMessage');
    const successDiv = document.getElementById('successMessage');

    // If redirected with success message, show it and clear user-entered fields (the account number already shows NEXT value from server)
    if (successDiv.textContent.trim() !== "") {
        successDiv.style.display = 'block';
        document.getElementById('name').value = "";
        document.getElementById('address').value = "";
        document.getElementById('phone').value = "";
        document.getElementById('unitsConsumed').value = "";
    }

    // Client-side validation
    document.getElementById('addCustomerForm').addEventListener('submit', function(e) {
        errorDiv.style.display = 'none';
        errorDiv.innerHTML = '';
        const errors = [];
        const form = e.target;

        if (!form.name.value.trim()) errors.push('Customer name is required.');
        if (!form.address.value.trim()) errors.push('Address is required.');
        if (!form.phone.value.trim()) errors.push('Telephone number is required.');
        if (!form.unitsConsumed.value || form.unitsConsumed.value < 0) errors.push('Units Consumed must be zero or more.');

        if (errors.length > 0) {
            errorDiv.innerHTML = '<strong>Please fix the following errors:</strong><br>' + errors.map(e => '• ' + e).join('<br>');
            errorDiv.style.display = 'block';
            e.preventDefault();
        }
    });
    */
</script>




</body>
</html>