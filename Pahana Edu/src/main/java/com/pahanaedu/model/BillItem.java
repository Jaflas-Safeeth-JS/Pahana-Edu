package com.pahanaedu.model;

public class BillItem {
    private int id;
    private int billId;
    private int bookId;
    private int quantity;
    private double unitPrice;
    private double lineTotal;

    public BillItem() {}

    public BillItem(int id, int billId, int bookId, int quantity, double unitPrice, double lineTotal) {
        this.id = id;
        this.billId = billId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.lineTotal = lineTotal;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getLineTotal() { return lineTotal; }
    public void setLineTotal(double lineTotal) { this.lineTotal = lineTotal; }
}
