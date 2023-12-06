package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.Doctor;
import su.ezhidze.server.entity.Patient;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.MedicalRecordResponseModel;
import su.ezhidze.server.model.MedicalRecordRegistrationModel;
import su.ezhidze.server.repository.DoctorRepository;
import su.ezhidze.server.repository.MedicalRecordRepository;
import su.ezhidze.server.entity.MedicalRecord;
import su.ezhidze.server.repository.PatientRepository;
import su.ezhidze.server.validator.Validator;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Service
public class MedicalRecordService {

    @Autowired
    private MedicalRecordRepository medicalRecordRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PatientService patientService;

    public ArrayList<MedicalRecordResponseModel> getMedicalRecords() {
        return new ArrayList<>(((Collection<MedicalRecord>) medicalRecordRepository.findAll()).stream().map(MedicalRecordResponseModel::new).toList());
    }

    public MedicalRecord getMedicalRecordById(Integer id) {
        return medicalRecordRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Medical record not found"));
    }

    public MedicalRecordResponseModel addNewMedicalRecord(final MedicalRecordRegistrationModel medicalRecordModel) {
        Validator.validate(medicalRecordModel);

        Patient patient = patientRepository.findById(medicalRecordModel.getPatientId()).orElseThrow(() -> new RecordNotFoundException("Patient not found"));
        Doctor doctor = doctorRepository.findById(medicalRecordModel.getDoctorId()).orElseThrow(() -> new RecordNotFoundException("Doctor not found"));
        MedicalRecord newMedicalRecord = new MedicalRecord(patient, doctor, medicalRecordModel.getRecordType(), medicalRecordModel.getMessageContent());
        MedicalRecordResponseModel response = new MedicalRecordResponseModel(medicalRecordRepository.save(newMedicalRecord));
        patientService.addMedicalRecord(medicalRecordModel.getPatientId(), newMedicalRecord);

        return response;
    }

    public void delete(Integer id) {
        MedicalRecord medicalRecord = medicalRecordRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Medical record not found"));
        Patient patient = medicalRecord.getPatient();
        patient.getMedicalRecords().remove(medicalRecord);
        patientRepository.save(patient);
        medicalRecordRepository.delete(medicalRecord);
    }

    public MedicalRecordResponseModel patch(Integer id, Map<String, Object> fields) {
        MedicalRecord medicalRecord = medicalRecordRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Medical record not found"));
        if (fields.get("recordType") != null) medicalRecord.setRecordType((String) fields.get("recordType"));
        if (fields.get("messageContent") != null) medicalRecord.setRecordType((String) fields.get("messageContent"));

        return new MedicalRecordResponseModel(medicalRecordRepository.save(medicalRecord));
    }
}
