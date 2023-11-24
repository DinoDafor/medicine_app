package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.Doctor;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.model.DoctorRegistrationModel;
import su.ezhidze.server.model.DoctorResponseModel;
import su.ezhidze.server.repository.DoctorRepository;
import su.ezhidze.server.validator.Validator;

@Service
public class DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public DoctorResponseModel addNewDoctor(final DoctorRegistrationModel doctorRegistrationModel) {
        if (doctorRepository.findByEmail(doctorRegistrationModel.getEmail()).isPresent()) {
            throw new DuplicateEntryException("This email is already associated with an account.");
        }

        Validator.validate(doctorRegistrationModel);

        Doctor newDoctor = new Doctor(doctorRegistrationModel);
        newDoctor.setPassword(passwordEncoder.encode(doctorRegistrationModel.getPassword()));

        return new DoctorResponseModel(doctorRepository.save(newDoctor));
    }

    public Doctor loadDoctorByEmail(String email) {
        return doctorRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("Doctor not found"));
    }
}
