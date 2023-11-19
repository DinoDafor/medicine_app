package su.ezhidze.server.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.Table;
import su.ezhidze.server.model.PatientRegistrationModel;

@Entity
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
}
