package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.TicketService;

import java.io.IOException;

@WebServlet("/tickets")
public class TicketServlet extends HttpServlet
{
    private final TicketService service = new TicketService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String action = req.getParameter("action");

        try
        {
            if ("form".equals(action))
            {
                req.setAttribute("sessions", service.getAllSessions());
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isBlank())
                {
                    req.setAttribute("ticket", service.getTicketById(Integer.parseInt(idParam)));
                    req.setAttribute("mode", "edit");
                }
                else
                {
                    req.setAttribute("ticket", null);
                    req.setAttribute("mode", "create");
                }
                req.getRequestDispatcher("/WEB-INF/views/tickets/form.jsp").forward(req, resp);
            }
            else
            {
                req.setAttribute("tickets", service.getAllTickets());
                req.getRequestDispatcher("/WEB-INF/views/tickets/list.jsp").forward(req, resp);
            }
        } catch (NumberFormatException e)
        {
            handleError(req, resp, new IllegalArgumentException("Невірний формат ID."));
        } catch (Exception e)
        {
            handleError(req, resp, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String action = req.getParameter("action");
        try
        {
            if ("delete".equals(action))
            {
                int id = Integer.parseInt(req.getParameter("id"));
                service.deleteTicket(id);
                resp.sendRedirect(req.getContextPath() + "/tickets?success=deleted");
            }
            else
            {
                String idParam = req.getParameter("id");
                int sessionId   = Integer.parseInt(req.getParameter("sessionId"));
                int rowNumber   = Integer.parseInt(req.getParameter("rowNumber"));
                int seatNumber  = Integer.parseInt(req.getParameter("seatNumber"));
                double price    = Double.parseDouble(req.getParameter("price"));
                boolean isSold  = "on".equals(req.getParameter("isSold"))
                        || "true".equals(req.getParameter("isSold"));
                String ownerName = req.getParameter("ownerName");

                if (idParam == null || idParam.isBlank())
                {
                    service.createTicket(sessionId, rowNumber, seatNumber, price, isSold, ownerName);
                    resp.sendRedirect(req.getContextPath() + "/tickets?success=created");
                }
                else
                {
                    service.updateTicket(Integer.parseInt(idParam), sessionId, rowNumber, seatNumber, price, isSold, ownerName);
                    resp.sendRedirect(req.getContextPath() + "/tickets?success=updated");
                }
            }
        }
        catch (NumberFormatException e)
        {
            handleError(req, resp, new IllegalArgumentException("Перевірте числові поля (ряд, місце, ціна)."));
        }
        catch (IllegalArgumentException e)
        {
            handleError(req, resp, e);
        }
        catch (Exception e)
        {
            handleError(req, resp, e);
        }
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, Exception e)
            throws ServletException, IOException
    {
        req.setAttribute("errorMessage", "Помилка в опрацюванні запиту");
        req.setAttribute("errorDetail", e.getMessage());
        req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
    }
}