package com.pahanaedu.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Bill {
    private int id;
    private String customerAccNo;
    private Date billDate;
    private double total;
    private List<BillItem> items = new ArrayList<>();

    public Bill() {}

    public Bill(int id, String customerAccNo, Date billDate, double total) {
        this.id = id;
        this.customerAccNo = customerAccNo;
        this.billDate = billDate;
        this.total = total;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCustomerAccNo() { return customerAccNo; }
    public void setCustomerAccNo(String customerAccNo) { this.customerAccNo = customerAccNo; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public List<BillItem> getItems() { return items; }
    public void setItems(List<BillItem> items) { this.items = items; }
}
