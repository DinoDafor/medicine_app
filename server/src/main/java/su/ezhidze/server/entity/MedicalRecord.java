package su.ezhidze.server.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class MedicalRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    private Patient patient;

    @ManyToOne
    private Doctor doctor;

    private String recordType;

    private String messageContent;

    public MedicalRecord() {
    }

    public MedicalRecord(Patient patient, Doctor doctor, String recordType, String messageContent) {
        this.patient = patient;
        this.doctor = doctor;
        this.recordType = recordType;
        this.messageContent = messageContent;
    }
}
