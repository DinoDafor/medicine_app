package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.Patient;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.PatientRegistrationModel;
import su.ezhidze.server.model.PatientResponseModel;
import su.ezhidze.server.repository.PatientRepository;
import su.ezhidze.server.validator.Validator;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Service
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    public PatientResponseModel addNewPatient(final PatientRegistrationModel patientRegistrationModel) {
        if (patientRepository.findByEmail(patientRegistrationModel.getEmail()).isPresent()) {
            throw new DuplicateEntryException("This email is already associated with an account.");
        }

        Validator.validate(patientRegistrationModel);

        Patient newPatient = new Patient(patientRegistrationModel);
        newPatient.setPassword(passwordEncoder.encode(patientRegistrationModel.getPassword()));

        return new PatientResponseModel(patientRepository.save(newPatient));
    }

    public ArrayList<PatientResponseModel> getPatients() {
        return new ArrayList<>(((Collection<Patient>) patientRepository.findAll()).stream().map(PatientResponseModel::new).toList());
    }

    public Patient getPatientById(Integer id) {
        return patientRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Patient not found"));
    }

    public void delete(Integer id) {
        Patient patient = patientRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Patient not found"));
        patientRepository.delete(patient);
    }

    public PatientResponseModel patch(Integer id, Map<String, Object> fields) {
        Patient patient = patientRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Patient not found"));
        userService.patchUser(patient, fields);

        if (fields.get("dateOfBirth") != null) patient.setDateOfBirth((String) fields.get("dateOfBirth"));
        if (fields.get("gender") != null) patient.setGender((String) fields.get("gender"));
        if (fields.get("contactNumber") != null) patient.setContactNumber((String) fields.get("contactNumber"));
        if (fields.get("address") != null) patient.setAddress((String) fields.get("address"));
        if (fields.get("otherRelevantInfo") != null) patient.setOtherRelevantInfo((String) fields.get("otherRelevantInfo"));

        return new PatientResponseModel(patientRepository.save(patient));
    }

    public Patient loadPatientByEmail(String email) {
        return patientRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("Patient not found"));
    }
}
