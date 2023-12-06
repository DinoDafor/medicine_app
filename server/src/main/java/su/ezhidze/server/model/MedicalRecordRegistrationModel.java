package su.ezhidze.server.model;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class MedicalRecordRegistrationModel {

    @NotNull(message = "patientId cannot be null")
    private Integer patientId;

    @NotNull(message = "doctorId cannot be null")
    private Integer doctorId;

    @NotNull(message = "recordType cannot be null")
    private String recordType;

    @NotNull(message = "messageContent cannot be null")
    private String messageContent;

}
