package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.entity.User;

import java.util.Map;

@Getter
@Setter
public class UserResponseModel {

    private Integer id;

    private String firstName;

    private String lastName;

    private String email;

    private String role;

    private String UUID;

    private Boolean isOnline;

    public UserResponseModel(final User user) {
        id = user.getId();
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
        role = user.getRole();
        UUID = user.getUUID();
        isOnline = user.getIsOnline();
    }

    public Map<String, Object> toMap() {
        return Map.of(
                "id", id.toString(),
                "firstName", firstName,
                "lastName", lastName,
                "email", email,
                "role", role,
                "UUID", UUID,
                "isOnline", isOnline);
    }
}
