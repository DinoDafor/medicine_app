package su.ezhidze.server.model;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DoctorRegistrationModel extends UserRegistrationModel {

    @NotNull(message = "specialization cannot be null")
    private String specialization;

    @NotNull(message = "contactNumber cannot be null")
    @Size(min = 1, message = "contactNumber should not be empty")
    @Size(max = 100, message = "contactNumber length should not be greater than 100 symbols")
    private String contactNumber;

    @NotNull(message = "clinicAddress cannot be null")
    @Size(min = 1, message = "clinicAddress should not be empty")
    @Size(max = 100, message = "clinicAddress length should not be greater than 100 symbols")
    private String clinicAddress;

    private String otherRelevantInfo;
}
