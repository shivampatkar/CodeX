package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;

@WebServlet("/user_management.do")
public class UserManagementServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("home.jsp");
            return;
        }
        

        try {

            int page = 1;
            int recordsPerPage = 10;
            String pageParam = request.getParameter("page");
        
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam); 
            }
    

            User users = new User();
            List<User> usersList = users.getAllUsers(page, recordsPerPage);
            int totalUsers = users.getTotalUsersCount();
            int totalPages = (int) Math.ceil(totalUsers * 1.0 / recordsPerPage);

            // Getting summary statistics
            int activeUsers = users.getUserCountByStatus(1);
            int bannedUsers = users.getUserCountByStatus(3); 
            int moderators = users.getUserCountByType(2);   

            // Setting attributes
            request.setAttribute("usersList", usersList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);

            // Summary stats
            request.setAttribute("totalUsersCount", totalUsers);
            request.setAttribute("activeUsersCount", activeUsers);
            request.setAttribute("moderatorCount", moderators);
            request.setAttribute("bannedCount", bannedUsers);

            request.getRequestDispatcher("user_management.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
   
