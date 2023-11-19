package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.Patient;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.model.PatientRegistrationModel;
import su.ezhidze.server.model.PatientResponseModel;
import su.ezhidze.server.repository.PatientRepository;
import su.ezhidze.server.validator.Validator;

@Service
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public PatientResponseModel addNewPatient(final PatientRegistrationModel patientRegistrationModel) {
        if (patientRepository.findByEmail(patientRegistrationModel.getEmail()).isPresent()) {
            throw new DuplicateEntryException("This email is already associated with an account.");
        }

        Validator.validate(patientRegistrationModel);

        Patient newPatient = new Patient(patientRegistrationModel);
        newPatient.setPassword(passwordEncoder.encode(patientRegistrationModel.getPassword()));

        return new PatientResponseModel(patientRepository.save(newPatient));
    }

    public Patient loadPatientByEmail(String email) {
        return patientRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("Patient not found"));
    }
}
