package su.ezhidze.server.entity;

import jakarta.persistence.*;
import lombok.Data;
import su.ezhidze.server.model.UserRegistrationModel;

@Entity
@Data
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private Integer id;

    private String firstName;

    private String lastName;

    private String email;

    private String password;

    public User() {
    }

    public User(final User user) {
        id = user.getId();
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
        password = user.getPassword();
    }

    public User(final UserRegistrationModel userRegistrationModel) {
        firstName = userRegistrationModel.getFirstName();
        lastName = userRegistrationModel.getLastName();
        email = userRegistrationModel.getEmail();
        password = userRegistrationModel.getPassword();
    }
}
