package su.ezhidze.server.service;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.User;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.BadArgumentException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.AuthenticationModel;
import su.ezhidze.server.model.UserModel;
import su.ezhidze.server.repository.UserRepository;

import java.util.Set;

@Service
public class UserService {

    private static final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    @Autowired
    private UserRepository userRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    public UserModel addNewUser(final User user) {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new DuplicateEntryException("This email is already associated with an account.");
        }

        Set<ConstraintViolation<User>> violations = validator.validate(user);
        if (!violations.isEmpty()) {
            StringBuilder message = new StringBuilder();
            for (ConstraintViolation<User> i : violations) {
                message.append(i.getMessage()).append(". ");
            }
            throw new BadArgumentException(message.toString());
        }

        User newUser = new User(user);
        newUser.setPassword(passwordEncoder.encode(user.getPassword()));

        return new UserModel(userRepository.save(newUser));
    }

    public UserModel getUserData(AuthenticationModel authenticationModel) {
        User user = userRepository.findByEmail(authenticationModel.getEmail()).orElseThrow(() -> new AuthenticationFailException("Wrong username or password"));

        if (passwordEncoder.matches(authenticationModel.getPassword(), user.getPassword())) {
            return new UserModel(user);
        } else throw new AuthenticationFailException("Wrong username or password");
    }
}
