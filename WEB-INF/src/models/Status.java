package models;

public class Status {
    private Integer statusId;
    private String name;
    private String category;

    public Status(){
        
    }

    public Status(Integer statusId){
        this.statusId = statusId;
    }

    // setter - getttter 

    public void setCategory(String category){
        this.category = category;
    }

    public String getCategory(){
        return category;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }

    public void setStatusId(Integer statusId){
        this.statusId = statusId;
    }

    public Integer getStatusId(){
        return statusId;
    }

}
