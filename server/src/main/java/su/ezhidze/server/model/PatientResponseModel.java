package su.ezhidze.server.model;

import lombok.Data;
import su.ezhidze.server.entity.Patient;

import java.util.Map;

@Data
public class PatientResponseModel extends UserResponseModel {

    private String dateOfBirth;

    private String gender;

    private String contactNumber;

    private String address;

    private String otherRelevantInfo;

    public PatientResponseModel(final Patient patient) {
        super(patient);
        dateOfBirth = patient.getDateOfBirth();
        gender = patient.getGender();
        contactNumber = patient.getContactNumber();
        address = patient.getAddress();
        otherRelevantInfo = patient.getOtherRelevantInfo();
    }

    @Override
    public Map<String, Object> toMap() {
        return Map.of(
                "id", super.getId().toString(),
                "firstName", super.getFirstName(),
                "lastName", super.getLastName(),
                "email", super.getEmail(),
                "dateOfBirth", dateOfBirth,
                "gender", gender,
                "contactNumber", contactNumber,
                "address", address,
                "otherRelevantInfo", otherRelevantInfo);
    }
}
