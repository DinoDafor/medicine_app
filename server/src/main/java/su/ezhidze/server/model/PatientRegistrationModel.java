package su.ezhidze.server.model;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class PatientRegistrationModel extends UserRegistrationModel {

    @NotNull(message = "Date of birth cannot be null")
    private String dateOfBirth;

    @NotNull(message = "Gender field name cannot be null")
    private String gender;

    @NotNull(message = "Contact number cannot be null")
    @Size(min = 1, message = "Contact number should not be empty")
    @Size(max = 100, message = "Contact number length should not be greater than 100 symbols")
    private String contactNumber;

    @NotNull(message = "Address cannot be null")
    @Size(min = 1, message = "Address should not be empty")
    @Size(max = 100, message = "Address length should not be greater than 100 symbols")
    private String address;

    private String otherRelevantInfo;
}
