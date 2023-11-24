package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.enums.Role;
import su.ezhidze.server.entity.User;

import java.util.Map;

@Getter
@Setter
public class UserResponseModel {

    private Integer id;

    private String firstName;

    private String lastName;

    private String email;

    private Role role;

    public UserResponseModel(final User user) {
        id = user.getId();
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
        role = user.getRole();
    }

    public Map<String, Object> toMap() {
        return Map.of(
                "id", id.toString(),
                "firstName", firstName,
                "lastName", lastName,
                "email", email,
                "role", role);
    }
}
