package su.ezhidze.server.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.model.UserRegistrationModel;

@Entity
@Getter
@Setter
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private Integer id;

    private String firstName;

    private String lastName;

    private String email;

    private String password;

    private String role;

    private String UUID;

    private Boolean isOnline;

    public User() {
        isOnline = false;
    }

    public User(final User user) {
        id = user.getId();
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
        password = user.getPassword();
        role = user.getRole();
        UUID = user.getUUID();
        isOnline = user.getIsOnline();
    }

    public User(final UserRegistrationModel userRegistrationModel) {
        firstName = userRegistrationModel.getFirstName();
        lastName = userRegistrationModel.getLastName();
        email = userRegistrationModel.getEmail();
        password = userRegistrationModel.getPassword();
        role = userRegistrationModel.getRole();
        isOnline = false;
    }
}
