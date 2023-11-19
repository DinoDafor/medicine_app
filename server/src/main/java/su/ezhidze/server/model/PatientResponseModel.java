package su.ezhidze.server.model;

import su.ezhidze.server.entity.Patient;

import java.util.Map;

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

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOtherRelevantInfo() {
        return otherRelevantInfo;
    }

    public void setOtherRelevantInfo(String otherRelevantInfo) {
        this.otherRelevantInfo = otherRelevantInfo;
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
