<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Bill</title>
<style>
    /* Reuse the vibe of addCustomer.jsp */
    * { box-sizing: border-box; }
    body {
        font-family: 'Arial', sans-serif;
        min-height: 100vh;  
    }
    .container {
        background: rgba(255,255,255,0.95); backdrop-filter: blur(10px);
        border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        padding: 30px; width: 100%; max-width: 1000px;  overflow-y: auto;
    }
    h1 {
        color: #333; font-size: 2rem; margin-bottom: 10px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }
    .row { display: grid; grid-template-columns: 1fr; gap: 10px; }
    .field { position: relative; }
    label { display: block; margin-bottom: 6px; color: #333; font-weight: 600; }
    input[type="text"], input[type="number"] {
        width: 100%; padding: 12px; border: 2px solid #e1e8ed; border-radius: 10px; background: rgba(255,255,255,0.8);
    }
    .btn { padding: 10px 14px; background: linear-gradient(135deg, #667eea, #764ba2); color: #fff; border: none; border-radius: 10px; cursor: pointer; }
    .btn:hover { opacity: .95; transform: translateY(-1px); }
    .badge { display:inline-block; padding: 6px 10px; border-radius: 999px; background:#eef; color:#334; font-size:.85rem; margin-top:6px;}
    .suggest { position:absolute; z-index: 10; top: 100%; left:0; right:0; background:#fff; border:1px solid #ddd; border-radius:8px; overflow:hidden; display:none; max-height:240px; overflow-y:auto; }
    .suggest div { padding:10px; cursor:pointer; }
    .suggest div:hover { background:#f6f7fb; }

    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th, td { border: 1px solid #e6e6e6; padding: 10px; text-align: left; }
    th { background:#f7f7ff; }
    tfoot td { font-weight: 700; }
    .right { text-align:right; }
    .error, .success { margin: 8px 0 12px; padding: 10px; border-radius: 8px; }
    .error { background: rgba(220, 53, 69, 0.1); border: 1px solid rgba(220, 53, 69, 0.2); color: #dc3545; }
    .success { background: rgba(40, 167, 69, 0.1); border: 1px solid rgba(40, 167, 69, 0.2); color: #28a745; }
    
    .main-content {
    margin-left: 200px; 
    padding: 20px;
}

    @media (min-width: 700px) { .row { grid-template-columns: 2fr 2fr 1fr; } }
</style>
</head>
<body>
<div class="main-content">
<div class="container">
    <h1>Create Bill</h1>

    <% if (request.getParameter("error") != null) { %>
        <div class="error"><%= request.getParameter("error") %></div>
    <% } %>

    <form method="post" action="billing" id="billForm">
        <!-- CUSTOMER SEARCH -->
        <div class="row">
            <div class="field" style="grid-column: span 2;">
                <label>Customer (Account No or Name)</label>
                <input type="text" id="customerSearch" placeholder="Type account no or name...">
                <div id="customerSuggest" class="suggest"></div>
                <div id="selectedCustomer" class="badge" style="display:none;"></div>
                <input type="hidden" name="customerAccNo" id="customerAccNo">
            </div>

            <div class="field">
                <label>Book search (ISBN or Title)</label>
                <input type="text" id="bookSearch" placeholder="Type ISBN or title...">
                <div id="bookSuggest" class="suggest"></div>
            </div>
        </div>

        <!-- ITEMS TABLE -->
        <table id="itemsTable">
            <thead>
            <tr>
                <th>Book</th>
                <th class="right">Unit Price</th>
                <th class="right">Qty</th>
                <th class="right">Line Total</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="itemsBody">
            <!-- rows will be added by JS -->
            </tbody>
            <tfoot>
            <tr>
                <td colspan="3" class="right">TOTAL</td>
                <td class="right" id="grandTotal">0.00</td>
                <td></td>
            </tr>
            </tfoot>
        </table>

        <br>
        <button type="submit" class="btn">Save Bill</button>
    </form>
</div>
</div>
<script>
const customerInput = document.getElementById('customerSearch');
const customerSuggest = document.getElementById('customerSuggest');
const customerAccNoHidden = document.getElementById('customerAccNo');
const selectedCustomer = document.getElementById('selectedCustomer');

const bookInput = document.getElementById('bookSearch');
const bookSuggest = document.getElementById('bookSuggest');
const itemsBody = document.getElementById('itemsBody');
const grandTotalEl = document.getElementById('grandTotal');

let cart = []; // {bookId, isbn, title, price, qty, stock}

function format(num) { return Number(num).toFixed(2); }

// --- CUSTOMER AUTOCOMPLETE ---
customerInput.addEventListener('input', async (e) => {
    const q = e.target.value.trim();
    if (!q) { customerSuggest.style.display = 'none'; return; }
    const res = await fetch('searchCustomers?q=' + encodeURIComponent(q));
    const list = await res.json();
    customerSuggest.innerHTML = '';
    list.forEach(c => {
        const div = document.createElement('div');
        div.textContent = c.accountNumber + "_" +  c.name;
        div.onclick = () => {
            customerAccNoHidden.value = c.accountNumber;
            selectedCustomer.style.display = 'inline-block';
            selectedCustomer.textContent = c.accountNumber + "_" +  c.name;
            customerSuggest.style.display = 'none';
            customerInput.value = '';
        };
        customerSuggest.appendChild(div);
    });
    customerSuggest.style.display = list.length ? 'block' : 'none';
});

// Close suggests on outside click
document.addEventListener('click', (e) => {
    if (!customerSuggest.contains(e.target) && e.target !== customerInput) {
        customerSuggest.style.display = 'none';
    }
    if (!bookSuggest.contains(e.target) && e.target !== bookInput) {
        bookSuggest.style.display = 'none';
    }
});

// --- BOOK AUTOCOMPLETE ---
bookInput.addEventListener('input', async (e) => {
    const q = e.target.value.trim();
    if (!q) { bookSuggest.style.display = 'none'; return; }
    const res = await fetch('searchBooks?q=' + encodeURIComponent(q));
    const list = await res.json();
    bookSuggest.innerHTML = '';
    list.forEach(b => {
        const div = document.createElement('div');
        div.textContent = b.isbn + " — " + b.title + " (Rs. " + b.price.toFixed(2) + " | stock " + b.stock + ")";

        div.onclick = () => {
            addToCart(b);
            bookSuggest.style.display = 'none';
            bookInput.value = '';
        };
        bookSuggest.appendChild(div);
    });
    bookSuggest.style.display = list.length ? 'block' : 'none';
});

function addToCart(b) {
    // if already in cart -> increase qty by 1 (if stock allows)
    const found = cart.find(it => it.bookId === b.id);
    if (found) {
        if (found.qty + 1 > found.stock) { alert('Not enough stock'); return; }
        found.qty++;
    } else {
        cart.push({ bookId: b.id, isbn: b.isbn, title: b.title, price: Number(b.price), qty: 1, stock: b.stock });
    }
    renderCart();
}

function renderCart() {
    itemsBody.innerHTML = '';
    let total = 0;

    cart.forEach((it, idx) => {
        const tr = document.createElement('tr');

        const tdBook = document.createElement('td');
        tdBook.textContent = it.isbn + "_" + it.title;
        tr.appendChild(tdBook);

        const tdPrice = document.createElement('td');
        tdPrice.className = 'right';
        tdPrice.textContent = format(it.price);
        // hidden field price[]
        const priceInput = document.createElement('input');
        priceInput.type = 'hidden'; priceInput.name = 'price'; priceInput.value = it.price;
        tdPrice.appendChild(priceInput);
        tr.appendChild(tdPrice);

        const tdQty = document.createElement('td');
        tdQty.className = 'right';
        const qtyInput = document.createElement('input');
        qtyInput.type = 'number'; qtyInput.name = 'quantity'; qtyInput.min = '1'; qtyInput.max = String(it.stock);
        qtyInput.value = String(it.qty);
        qtyInput.style.width = '80px';
        qtyInput.onchange = (e) => {
            let v = parseInt(e.target.value || '1');
            if (v < 1) v = 1;
            if (v > it.stock) { alert('Not enough stock'); v = it.stock; }
            it.qty = v;
            renderCart();
        };
        tdQty.appendChild(qtyInput);
        tr.appendChild(tdQty);

        const line = it.qty * it.price;
        total += line;

        const tdLine = document.createElement('td');
        tdLine.className = 'right';
        tdLine.textContent = format(line);
        tr.appendChild(tdLine);

        const tdAct = document.createElement('td');
        const btn = document.createElement('button'); btn.type = 'button'; btn.className = 'btn';
        btn.textContent = 'Remove';
        btn.onclick = () => { cart.splice(idx,1); renderCart(); };
        tdAct.appendChild(btn);
        tr.appendChild(tdAct);

        // hidden bookId[]
        const idInput = document.createElement('input');
        idInput.type = 'hidden'; idInput.name = 'bookId'; idInput.value = it.bookId;
        tr.appendChild(idInput);

        itemsBody.appendChild(tr);
    });

    grandTotalEl.textContent = format(total);
}

// Validate submit
document.getElementById('billForm').addEventListener('submit', (e) => {
    if (!document.getElementById('customerAccNo').value) {
        alert('Please select a customer'); e.preventDefault(); return;
    }
    if (cart.length === 0) {
        alert('Please add at least one book'); e.preventDefault(); return;
    }
});
</script>
</body>
</html>
