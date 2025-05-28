package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import models.User;
import models.Status;
import models.UserType;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        String email = request.getParameter("uemail");
        String password = request.getParameter("upassword");

        String nextPage = "index.do?login_status=";

        User user = new User(email, password);

        if (user.loginUser()) {
            if (user.getUserType() == null) {
                nextPage = "index.do?login_status=error";  // No user type found
            } else {
                int userTypeId = user.getUserType().getUserTypeId();
                UserType userType = new UserType();
                String role = userType.getRoleByUserTypeId(userTypeId);

                Status userStatus = user.getStatus();

                if (userStatus == null) {
                    nextPage = "index.do?login_status=error";  // No status found for user
                } else {
                    switch (userStatus.getStatusId()) {
                        case 1: // Active status
                            session.setAttribute("user", user);
                            session.setAttribute("userRole", role);
                            nextPage = getRedirectPage(role);
                            break;
                        case 2: // Inactive status
                            nextPage = "index.do?login_status=inactive";  // Redirect to inactive page
                            break;
                        case 3: // Suspended status
                            nextPage = "index.do?login_status=suspended";  // Redirect to suspended page
                            break;
                        default:
                            nextPage = "index.do?login_status=failed";  // For unknown statuses
                            break;
                    }
                }
            }
        } else {
            nextPage = "index.do?login_status=error";  // Invalid credentials or login failed
        }

        response.sendRedirect(nextPage);  // Redirect based on status
    }
    
    // Method to determine the redirect page based on user role
    private String getRedirectPage(String role) {
        switch (role) {
            case "admin":
                return "admin_dashboard.do"; 
            case "moderator":
                return "moderator_dashboard.do";  
            case "user":
                return "index.do";  
            default:
                return "index.do?login_status=error";
        }
    }
}
