package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.TicketService;

import java.io.IOException;

@WebServlet("/tickets")
public class TicketListServlet extends HttpServlet
{
    private final TicketService service = new TicketService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        try
        {
            req.setAttribute("tickets", service.getAllTickets());
            req.getRequestDispatcher("/WEB-INF/views/tickets/list.jsp")
                    .forward(req, resp);
        }
        catch (Exception e)
        {
            handleError(req, resp, e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String action = req.getParameter("action");

        if ("delete".equals(action))
        {
            try
            {
                int id = Integer.parseInt(req.getParameter("id"));
                service.deleteTicket(id);
                resp.sendRedirect(req.getContextPath() + "/tickets?success=deleted");
            }
            catch (NumberFormatException e)
            {
                handleError(req, resp, new IllegalArgumentException("Невірний формат ID."));
            }
            catch (Exception e)
            {
                handleError(req, resp, e);
            }
        }
        else
        {
            resp.sendRedirect(req.getContextPath() + "/tickets");
        }
    }
    private void handleError(HttpServletRequest req, HttpServletResponse resp, Exception e)
            throws ServletException, IOException
    {
        req.setAttribute("errorMessage", "Помилка в опрацюванні запиту");
        req.setAttribute("errorDetail",  e.getMessage());
        req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
    }
}
