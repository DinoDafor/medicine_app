package su.ezhidze.server.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.model.PatientRegistrationModel;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
public class Patient extends User {

    private String dateOfBirth;

    private String gender;

    private String contactNumber;

    private String address;

    private String otherRelevantInfo;

    @OneToMany(fetch = FetchType.EAGER)
    private List<MedicalRecord> medicalRecords;

    public Patient() {
        otherRelevantInfo = "";
        medicalRecords = new ArrayList<>();
    }

    public Patient(final PatientRegistrationModel patientRegistrationModel) {
        super(patientRegistrationModel);
        dateOfBirth = patientRegistrationModel.getDateOfBirth();
        gender = patientRegistrationModel.getGender();
        contactNumber = patientRegistrationModel.getContactNumber();
        address = patientRegistrationModel.getAddress();
        otherRelevantInfo = patientRegistrationModel.getOtherRelevantInfo();
        medicalRecords = new ArrayList<>();
        super.setRole("PATIENT");
    }
}
