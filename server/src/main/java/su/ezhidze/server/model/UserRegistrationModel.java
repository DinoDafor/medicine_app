package su.ezhidze.server.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRegistrationModel {

    @NotNull(message = "firstName cannot be null")
    @Size(min = 1, message = "firstName should not be empty")
    @Size(max = 100, message = "firstName length should not be greater than 100 symbols")
    private String firstName;

    @NotNull(message = "lastName cannot be null")
    @Size(min = 1, message = "lastName should not be empty")
    @Size(max = 100, message = "lastName length should not be greater than 100 symbols")
    private String lastName;

    @NotNull(message = "email cannot be null")
    @Email(regexp = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", message = "Invalid email address")
    private String email;

    @NotNull(message = "password cannot be null")
    @Pattern(regexp = "(?=.*[0-9]).+", message = "A digit must occur at least once in password")
    @Pattern(regexp = "(?=.*[a-z]).+", message = "A lower case letter must occur at least once in password")
    @Pattern(regexp = "(?=.*[A-Z]).+", message = "An upper case letter must occur at least once in password")
    @Pattern(regexp = "(?=.*[@#$%^&+=]).+", message = "A special character(@#$%^&+=) must occur at least once in password")
    @Pattern(regexp = "(?=\\S+$).+", message = "No whitespace allowed in the entire password")
    @Pattern(regexp = ".{8,}.+", message = "password should contain at least 8 characters")
    private String password;
}
