package su.ezhidze.server.entity;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.model.DoctorRegistrationModel;

@Entity
@Getter
@Setter
public class Doctor extends User {

    private String specialization;

    private String contactNumber;

    private String clinicAddress;

    private String otherRelevantInfo;

    public Doctor() { otherRelevantInfo = ""; }

    public Doctor(final DoctorRegistrationModel doctorRegistrationModel) {
        super(doctorRegistrationModel);
        specialization = doctorRegistrationModel.getSpecialization();
        contactNumber = doctorRegistrationModel.getContactNumber();
        clinicAddress = doctorRegistrationModel.getClinicAddress();
        otherRelevantInfo = doctorRegistrationModel.getOtherRelevantInfo();
    }
}
