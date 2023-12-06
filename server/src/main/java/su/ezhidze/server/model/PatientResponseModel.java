package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.entity.Patient;

import java.util.List;
import java.util.Map;

@Getter
@Setter
public class PatientResponseModel extends UserResponseModel {

    private String dateOfBirth;

    private String gender;

    private String contactNumber;

    private String address;

    private List<MedicalRecordResponseModel> medicalRecords;

    private String otherRelevantInfo;

    public PatientResponseModel(final Patient patient) {
        super(patient);
        dateOfBirth = patient.getDateOfBirth();
        gender = patient.getGender();
        contactNumber = patient.getContactNumber();
        address = patient.getAddress();
        medicalRecords = patient.getMedicalRecords().stream().map(MedicalRecordResponseModel::new).toList();
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
                "medicalRecords", medicalRecords,
                "otherRelevantInfo", otherRelevantInfo);
    }
}
