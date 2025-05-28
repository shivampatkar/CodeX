package listeners;

import java.util.TreeSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import models.Country;
import utils.DBConnect;
import models.Topic;

@WebListener
public class AppListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent ev) {
        ServletContext context = ev.getServletContext();

        // -- ############# Setup BMT DB ############# --
        DBConnect.dbURL = context.getInitParameter("dburl");
        DBConnect.dbUser = context.getInitParameter("dbuser");
        DBConnect.dbPassword = context.getInitParameter("dbpassword");

        // -- ############# Collect Cities ############ --
        TreeSet<Country> countries = Country.collectCountries();
        context.setAttribute("countries", countries);

        // ----######### Collect Topics ######------
        ArrayList<Topic> topics = Topic.collectTopics();
        context.setAttribute("topics", topics); 
    }

    public void contextDestroyed(ServletContextEvent ev) {
        
    }
}