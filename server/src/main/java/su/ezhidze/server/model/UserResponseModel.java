package su.ezhidze.server.model;

import lombok.Data;
import su.ezhidze.server.entity.User;

import java.util.Map;

@Data
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

    public Map<String, Object> toMap() {
        return Map.of(
                "id", id.toString(),
                "firstName", firstName,
                "lastName", lastName,
                "email", email);
    }
}
