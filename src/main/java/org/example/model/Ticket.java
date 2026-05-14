package org.example.model;

import java.util.Objects;

public class Ticket
{
    private int id;
    private int sessionId;
    private int rowNumber;
    private int seatNumber;
    private double price;
    private boolean isSold;
    private String ownerName;
    private String movieName;
    private String cinemaName;
    private String sessionDate;
    private String sessionTime;

    public Ticket() {}
    public Ticket(int id, int sessionId, int rowNumber, int seatNumber, double price)
    {
        if (rowNumber  < 1 || rowNumber  > 10)
            throw new IllegalArgumentException("Ряд має бути від 1 до 10.");
        if (seatNumber < 1 || seatNumber > 20)
            throw new IllegalArgumentException("Місце має бути від 1 до 20.");
        if (price <= 0)
            throw new IllegalArgumentException("Ціна має бути більше 0.");
        this.id = id;
        this.sessionId = sessionId;
        this.rowNumber = rowNumber;
        this.seatNumber = seatNumber;
        this.price = price;
        this.isSold = false;
        this.ownerName = null;
    }

    public int getId() { return id; }
    public int getSessionId() { return sessionId; }
    public int getRowNumber() { return rowNumber; }
    public int getSeatNumber() { return seatNumber; }
    public double getPrice() { return price; }
    public boolean isSold() { return isSold; }
    public String getOwnerName() { return ownerName; }
    public String getMovieName() { return movieName; }
    public String getCinemaName() { return cinemaName; }
    public String getSessionDate() { return sessionDate; }
    public String getSessionTime() { return sessionTime; }

    public void setId(int id) { this.id = id; }
    public void setSessionId(int sessionId) { this.sessionId = sessionId; }
    public void setRowNumber(int rowNumber)
    {
        if (rowNumber < 1 || rowNumber > 10)
            throw new IllegalArgumentException("Ряд має бути від 1 до 10.");
        this.rowNumber = rowNumber;
    }
    public void setSeatNumber(int seatNumber)
    {
        if (seatNumber < 1 || seatNumber > 20)
            throw new IllegalArgumentException("Місце має бути від 1 до 20.");
        this.seatNumber = seatNumber;
    }
    public void setPrice(double price)
    {
        if (price <= 0) throw new IllegalArgumentException("Ціна має бути більше 0.");
        this.price = price;
    }
    public void setSold(boolean sold) { this.isSold = sold; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    public void setMovieName(String movieName) { this.movieName = movieName; }
    public void setCinemaName(String cinemaName) { this.cinemaName = cinemaName; }
    public void setSessionDate(String d) { this.sessionDate = d; }
    public void setSessionTime(String t) { this.sessionTime = t; }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Ticket t = (Ticket) o;
        return id == t.id && sessionId == t.sessionId
                && rowNumber == t.rowNumber && seatNumber == t.seatNumber
                && Double.compare(price, t.price) == 0
                && isSold == t.isSold
                && Objects.equals(ownerName, t.ownerName);
    }
    @Override public int hashCode()
    {
        return Objects.hash(id, sessionId, rowNumber, seatNumber, price, isSold, ownerName);
    }
    @Override public String toString()
    {
        return "Ticket{id=" + id + ", session=" + sessionId
                + ", row=" + rowNumber + ", seat=" + seatNumber
                + ", price=" + price + ", sold=" + isSold + "}";
    }
}