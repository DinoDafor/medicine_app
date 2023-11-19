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
import su.ezhidze.server.repository.UserRepository;
import su.ezhidze.server.validator.Validator;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

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
        UserDetails userDetails =
                org.springframework.security.core.userdetails.User.builder()
                        .username(user.getEmail())
                        .password(user.getPassword())
                        .roles("USER")
                        .build();
        return userDetails;
    }

    public User loadUserByEmail(String email) {
        return userRepository.findByEmail(email).orElseThrow(() -> new AuthenticationFailException("User not found"));
    }
}
