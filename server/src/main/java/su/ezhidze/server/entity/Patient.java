package su.ezhidze.server.entity;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.model.PatientRegistrationModel;

@Entity
@Getter
@Setter
public class Patient extends User {

    private String dateOfBirth;

    private String gender;

    private String contactNumber;

    private String address;

    private String otherRelevantInfo;

    public Patient() {
        otherRelevantInfo = "";
    }

    public Patient(final PatientRegistrationModel patientRegistrationModel) {
        super(patientRegistrationModel);
        dateOfBirth = patientRegistrationModel.getDateOfBirth();
        gender = patientRegistrationModel.getGender();
        contactNumber = patientRegistrationModel.getContactNumber();
        address = patientRegistrationModel.getAddress();
        otherRelevantInfo = patientRegistrationModel.getOtherRelevantInfo();
        super.setRole("PATIENT");
    }
}
