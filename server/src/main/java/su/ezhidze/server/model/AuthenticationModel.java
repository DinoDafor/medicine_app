package su.ezhidze.server.model;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AuthenticationModel {

    @NotNull(message = "Email cannot be null")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    @NotNull(message = "Role cannot be null")
    private String role;
}
