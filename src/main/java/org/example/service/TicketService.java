package org.example.service;

import org.example.dao.SessionDao;
import org.example.dao.TicketDao;
import org.example.model.Session;
import org.example.model.Ticket;

import java.sql.SQLException;
import java.util.List;

public class TicketService
{
    private final TicketDao  ticketDao  = new TicketDao();
    private final SessionDao sessionDao = new SessionDao();

    public List<Ticket> getAllTickets() throws SQLException
    {
        return ticketDao.findAll();
    }
    public List<Ticket> getTicketsBySession(int sessionId) throws SQLException
    {
        return ticketDao.findBySession(sessionId);
    }
    public Ticket getTicketById(int id) throws SQLException
    {
        return ticketDao.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Квиток з ID " + id + " не знайдено."));
    }
    public Ticket createTicket(int sessionId, int rowNumber, int seatNumber,
                               double price, boolean isSold, String ownerName) throws SQLException
    {
        sessionDao.findById(sessionId)
                .orElseThrow(() -> new IllegalArgumentException("Сеанс з ID " + sessionId + " не існує."));

        validateRowNumber(rowNumber);
        validateSeatNumber(seatNumber);
        validatePrice(price);
        validateOwner(isSold, ownerName);

        Ticket t = new Ticket();
        t.setSessionId(sessionId);
        t.setRowNumber(rowNumber);
        t.setSeatNumber(seatNumber);
        t.setPrice(price);
        t.setSold(isSold);
        t.setOwnerName(isSold ? ownerName.trim() : null);

        return ticketDao.create(t);
    }
    public void updateTicket(int id, int sessionId, int rowNumber, int seatNumber,
                             double price, boolean isSold, String ownerName) throws SQLException
    {
        Ticket existing = getTicketById(id);

        sessionDao.findById(sessionId)
                .orElseThrow(() -> new IllegalArgumentException("Сеанс з ID " + sessionId + " не існує."));

        validateRowNumber(rowNumber);
        validateSeatNumber(seatNumber);
        validatePrice(price);
        validateOwner(isSold, ownerName);

        existing.setSessionId(sessionId);
        existing.setRowNumber(rowNumber);
        existing.setSeatNumber(seatNumber);
        existing.setPrice(price);
        existing.setSold(isSold);
        existing.setOwnerName(isSold ? ownerName.trim() : null);

        ticketDao.update(existing);
    }
    public void deleteTicket(int id) throws SQLException
    {
        getTicketById(id);
        ticketDao.delete(id);
    }
    public List<Session> getAllSessions() throws SQLException
    {
        return sessionDao.findAll();
    }
    private void validateRowNumber(int row)
    {
        if (row < 1 || row > 10)
            throw new IllegalArgumentException("Ряд має бути від 1 до 10.");
    }
    private void validateSeatNumber(int seat)
    {
        if (seat < 1 || seat > 20)
            throw new IllegalArgumentException("Місце має бути від 1 до 20.");
    }
    private void validatePrice(double price)
    {
        if (price <= 0)
            throw new IllegalArgumentException("Ціна має бути більше 0.");
    }
    private void validateOwner(boolean isSold, String ownerName)
    {
        if (isSold && (ownerName == null || ownerName.isBlank()))
            throw new IllegalArgumentException("Ім'я власника обов'язкове для проданого квитка.");
    }
}