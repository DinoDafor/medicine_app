package su.ezhidze.server.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.util.Collection;

public class UserRegistrationModel {

    @NotNull(message = "First name cannot be null")
    @Size(min = 1, message = "First name should not be empty")
    @Size(max = 100, message = "First name length should not be greater than 100 symbols")
    private String firstName;

    @NotNull(message = "Last name cannot be null")
    @Size(min = 1, message = "Last name should not be empty")
    @Size(max = 100, message = "Last name length should not be greater than 100 symbols")
    private String lastName;

    @NotNull(message = "Email cannot be null")
    @Email(regexp = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", message = "Invalid email address")
    private String email;

    @NotNull(message = "Password cannot be null")
    @Pattern(regexp = "(?=.*[0-9]).+", message = "A digit must occur at least once in password")
    @Pattern(regexp = "(?=.*[a-z]).+", message = "A lower case letter must occur at least once in password")
    @Pattern(regexp = "(?=.*[A-Z]).+", message = "An upper case letter must occur at least once in password")
    @Pattern(regexp = "(?=.*[@#$%^&+=]).+", message = "A special character(@#$%^&+=) must occur at least once in password")
    @Pattern(regexp = "(?=\\S+$).+", message = "No whitespace allowed in the entire password")
    @Pattern(regexp = ".{8,}.+", message = "Password should contain at least 8 characters")
    private String password;

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
