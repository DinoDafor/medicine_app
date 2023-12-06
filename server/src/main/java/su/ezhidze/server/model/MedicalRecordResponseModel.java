package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.entity.MedicalRecord;

@Getter
@Setter
public class MedicalRecordResponseModel {

    private Integer id;

    private Integer patientId;

    private Integer doctorId;

    private String recordType;

    private String messageContent;

    public MedicalRecordResponseModel(final MedicalRecord medicalRecord) {
        this.id = medicalRecord.getId();
        this.patientId = medicalRecord.getPatient().getId();
        this.doctorId = medicalRecord.getDoctor().getId();
        this.recordType = medicalRecord.getRecordType();
        this.messageContent = medicalRecord.getMessageContent();
    }
}
