package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.User;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.model.UserRegistrationModel;
import su.ezhidze.server.model.UserResponseModel;
import su.ezhidze.server.repository.DoctorRepository;
import su.ezhidze.server.repository.PatientRepository;
import su.ezhidze.server.repository.UserRepository;
import su.ezhidze.server.validator.Validator;

import java.util.Map;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserResponseModel addNewUser(final UserRegistrationModel userRegistrationModel) {
        if (userRepository.findByEmail(userRegistrationModel.getEmail()).isPresent()) {
            throw new DuplicateEntryException("This email is already associated with an account.");
        }

        Validator.validate(userRegistrationModel);

        User newUser = new User(userRegistrationModel);
        newUser.setPassword(passwordEncoder.encode(userRegistrationModel.getPassword()));

        return new UserResponseModel(userRepository.save(newUser));
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("User not found"));
        UserDetails userDetails = org.springframework.security.core.userdetails.User.builder().username(user.getEmail()).password(user.getPassword()).roles("USER").build();
        return userDetails;
    }

    public User loadUserByEmail(String email) {
        return userRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("User not found"));
    }

    public User patchUser(User user, Map<String, Object> fields) {
        if (fields.get("firstName") != null) user.setFirstName((String) fields.get("firstName"));
        if (fields.get("lastName") != null) user.setLastName((String) fields.get("lastName"));
        if (fields.get("email") != null) {
            if (patientRepository.findByEmail((String) fields.get("email")).isPresent() ||
                    doctorRepository.findByEmail((String) fields.get("email")).isPresent()) {
                throw new DuplicateEntryException("This email is already associated with an account.");
            }
            user.setEmail((String) fields.get("email"));
        }
        if (fields.get("password") != null) user.setPassword((String) fields.get("password"));

        return user;
    }
}
