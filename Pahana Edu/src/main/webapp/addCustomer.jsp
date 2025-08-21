<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Customer</title>
<style>
       
          body { font-family: Arial, sans-serif; background: #f4f6f9; }
        .container {
            width: 90%; max-width: 500px; margin: 40px auto; background: #fff;
            padding: 25px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 { text-align: center; margin-bottom: 20px; }
        form label { display: block; margin-top: 10px; font-weight: bold; }
        form input {
            width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc;
            border-radius: 6px; box-sizing: border-box;
        }
        .btn { margin-top: 15px; width: 100%; padding: 10px; background: #28a745; border: none;
            color: white; font-size: 16px; border-radius: 6px; cursor: pointer; }
        .btn:hover { opacity: 0.9; }
        .back-link { display: block; text-align: center; margin-top: 15px; }

        .required {
            color: #dc3545;
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

        <button type="submit" class="btn">Add Customer</button>
    </form>
</div>

<script>

//Client-side validation
document.getElementById('addCustomerForm').addEventListener('submit', function(e) {
    const errors = [];
    const form = e.target;

    const nameValue = form.name.value.trim();
    const addressValue = form.address.value.trim();
    const phoneValue = form.phone.value.trim();
    const unitsValue = form.unitsConsumed.value;

    // Validate customer name: not empty, at least 3 characters, no numbers
    if (!nameValue) {
        errors.push('Customer name is required.');
    } else if (nameValue.length < 3) {
        errors.push('Customer name must be at least 3 characters long.');
    } else if (/\d/.test(nameValue)) {
        errors.push('Customer name cannot contain numbers.');
    }

    if (!addressValue) errors.push('Address is required.');
    if (!phoneValue) errors.push('Telephone number is required.');
    if (!unitsValue || unitsValue < 0) errors.push('Units Consumed must be zero or more.');

    if (errors.length > 0) {
        alert("Please fix the following errors:\n" + errors.join("\n"));
        e.preventDefault();
    }
});
</script>




</body>
</html>