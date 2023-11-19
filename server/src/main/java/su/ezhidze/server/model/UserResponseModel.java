package su.ezhidze.server.model;

import su.ezhidze.server.entity.User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

public class UserResponseModel {

    private Integer id;

    private String firstName;

    private String lastName;

    private String email;

    public UserResponseModel(final User user) {
        id = user.getId();
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
    }

    public UserResponseModel(final UserRegistrationModel userRegistrationModel) {
        firstName = userRegistrationModel.getFirstName();
        lastName = userRegistrationModel.getLastName();
        email = userRegistrationModel.getEmail();
    }

    public UserResponseModel() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Map<String, Object> toMap() {
        return Map.of(
                "id", id.toString(),
                "firstName", firstName,
                "lastName", lastName,
                "email", email);
    }
}
