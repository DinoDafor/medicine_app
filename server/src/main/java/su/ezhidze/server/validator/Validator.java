package su.ezhidze.server.validator;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import su.ezhidze.server.exception.BadArgumentException;

import java.util.Set;

public class Validator {

    private static final jakarta.validation.Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    static public <T> void validate(T registrationModel) {
        Set<ConstraintViolation<T>> violations = validator.validate(registrationModel);
        if (!violations.isEmpty()) {
            StringBuilder message = new StringBuilder();
            for (ConstraintViolation<T> i : violations) {
                message.append(i.getMessage()).append(". ");
            }
            throw new BadArgumentException(message.toString());
        }
    }
}
