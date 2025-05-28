package models;

public class Moderator {
    private Integer moderatorId;
    private User user;             
    private Topic topic;           
    private String timezone;
    private Status status;
    
    public Integer getModeratorId() {
        return moderatorId;
    }
    public void setModeratorId(Integer moderatorId) {
        this.moderatorId = moderatorId;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    public Topic getTopic() {
        return topic;
    }
    public void setTopic(Topic topic) {
        this.topic = topic;
    }
    public String getTimezone() {
        return timezone;
    }
    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }
    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }         

    
}
