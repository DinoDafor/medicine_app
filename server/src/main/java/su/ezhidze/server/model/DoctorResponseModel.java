package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.entity.Doctor;

import java.util.Map;

@Getter
@Setter
public class DoctorResponseModel extends UserResponseModel {

    private String specialization;

    private String contactNumber;

    private String clinicAddress;

    private String otherRelevantInfo;

    public DoctorResponseModel(final Doctor doctor) {
        super(doctor);
        specialization = doctor.getSpecialization();
        contactNumber = doctor.getContactNumber();
        clinicAddress = doctor.getClinicAddress();
        otherRelevantInfo = doctor.getOtherRelevantInfo();
    }

    @Override
    public Map<String, Object> toMap() {
        return Map.of(
                "id", super.getId().toString(),
                "firstName", super.getFirstName(),
                "lastName", super.getLastName(),
                "email", super.getEmail(),
                "specialization", specialization,
                "contactNumber", contactNumber,
                "clinicAddress", clinicAddress,
                "otherRelevantInfo", otherRelevantInfo);
    }
}
