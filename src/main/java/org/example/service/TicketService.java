package org.example.service;

import org.example.dao.SessionDao;
import org.example.dao.TicketDao;
import org.example.model.Session;
import org.example.model.Ticket;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

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

    public Ticket createTicket(int sessionId, int rowNumber, int seatNumber, double price, boolean isSold, String ownerName) throws SQLException
    {
        sessionDao.findById(sessionId)
                .orElseThrow(() -> new IllegalArgumentException("Сеанс з ID " + sessionId + " не існує."));
        Ticket t = new Ticket(0, sessionId, rowNumber, seatNumber, price);
        if (isSold)
        {
            if (ownerName == null || ownerName.isBlank())
                throw new IllegalArgumentException("Ім'я власника обов'язкове для проданого квитка.");
            t.setSold(true);
            t.setOwnerName(ownerName.trim());
        }
        return ticketDao.create(t);
    }
    public void updateTicket(int id, int sessionId, int rowNumber, int seatNumber, double price, boolean isSold, String ownerName) throws SQLException {

        Ticket existing = getTicketById(id);
        sessionDao.findById(sessionId)
                .orElseThrow(() -> new IllegalArgumentException("Сеанс з ID " + sessionId + " не існує."));
        existing.setSessionId(sessionId);
        existing.setRowNumber(rowNumber);
        existing.setSeatNumber(seatNumber);
        existing.setPrice(price);
        existing.setSold(isSold);

        if (isSold)
        {
            if (ownerName == null || ownerName.isBlank())
                throw new IllegalArgumentException("Ім'я власника обов'язкове для проданого квитка.");
            existing.setOwnerName(ownerName.trim());
        }
        else
        {
            existing.setOwnerName(null);
        }
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
}