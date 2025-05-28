package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.TreeSet;

import utils.DBConnect;

public class Country {
    private Integer countryId;
    private String name;
    private String flag;


    Country() {

    }

    public Country(Integer countryId){
        this.countryId = countryId;
    }

    public Country(Integer countryId, String name, String flag) {
        this.countryId = countryId;
        this.name = name;
        this.flag = flag;
    }

    // method for collecting countries
    public static TreeSet<Country> collectCountries() {
        TreeSet<Country> countries = new TreeSet<>((c1, c2) -> c1.getName().compareTo(c2.getName()));

        Connection con = DBConnect.getConnection();

        String query = "select country_id, name, flag from countries"; 
        try{
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("country_id");
                String name = rs.getString("name");
                String flag = rs.getString("flag");

                countries.add(new Country(id, name, flag));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }

        return countries;
    }

    // getter and setter
    public void setCountryId(Integer countryId) {
        this.countryId = countryId;
    }

    public Integer getCountryId() {
        return countryId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getFlag() {
        return flag;
    }

}
