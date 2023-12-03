package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.Doctor;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.DoctorRegistrationModel;
import su.ezhidze.server.model.DoctorResponseModel;
import su.ezhidze.server.repository.DoctorRepository;
import su.ezhidze.server.validator.Validator;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Service
public class DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    public DoctorResponseModel addNewDoctor(final DoctorRegistrationModel doctorRegistrationModel) {
        if (doctorRepository.findByEmail(doctorRegistrationModel.getEmail()).isPresent()) {
            throw new DuplicateEntryException("This email is already associated with an account.");
        }

        Validator.validate(doctorRegistrationModel);

        Doctor newDoctor = new Doctor(doctorRegistrationModel);
        newDoctor.setPassword(passwordEncoder.encode(doctorRegistrationModel.getPassword()));

        return new DoctorResponseModel(doctorRepository.save(newDoctor));
    }

    public ArrayList<DoctorResponseModel> getDoctors() {
        return new ArrayList<>(((Collection<Doctor>) doctorRepository.findAll()).stream().map(DoctorResponseModel::new).toList());
    }

    public Doctor getDoctorById(Integer id) {
        return doctorRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Doctor not found"));
    }

    public void delete(Integer id) {
        Doctor doctor = doctorRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Doctor not found"));
        doctorRepository.delete(doctor);
    }

    public DoctorResponseModel patch(Integer id, Map<String, Object> fields) {
        Doctor doctor = doctorRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Doctor not found"));
        userService.patchUser(doctor, fields);

        if (fields.get("specialization") != null) doctor.setSpecialization((String) fields.get("specialization"));
        if (fields.get("contactNumber") != null) doctor.setContactNumber((String) fields.get("contactNumber"));
        if (fields.get("clinicAddress") != null) doctor.setClinicAddress((String) fields.get("clinicAddress"));
        if (fields.get("otherRelevantInfo") != null) doctor.setOtherRelevantInfo((String) fields.get("otherRelevantInfo"));

        return new DoctorResponseModel(doctorRepository.save(doctor));
    }

    public Doctor loadDoctorByEmail(String email) {
        return doctorRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("Doctor not found"));
    }
}
