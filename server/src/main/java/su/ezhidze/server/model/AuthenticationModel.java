package su.ezhidze.server.model;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.enums.Role;

@Getter
@Setter
public class AuthenticationModel {

    @NotNull(message = "Email cannot be null")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    @NotNull(message = "Role cannot be null")
    private Role role;
}
