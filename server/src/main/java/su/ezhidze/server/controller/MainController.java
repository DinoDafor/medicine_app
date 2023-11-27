package su.ezhidze.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import su.ezhidze.server.exception.BadArgumentException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.ExceptionBodyBuilder;
import su.ezhidze.server.model.*;
import su.ezhidze.server.service.DoctorService;
import su.ezhidze.server.service.PatientService;
import su.ezhidze.server.service.UserService;
import su.ezhidze.server.util.JwtUtil;
import su.ezhidze.server.validator.Validator;

import java.util.Map;
import java.util.Objects;

import static su.ezhidze.server.enums.Role.*;

@Controller
@RequestMapping(path = "/medApp")
public class MainController {

    private final AuthenticationManager authenticationManager;

    private JwtUtil jwtUtil;

    @Autowired
    private UserService userService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    public MainController(AuthenticationManager authenticationManager, JwtUtil jwtUtil) {
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping(path = "/registration")
    public ResponseEntity addNewUser(@RequestBody UserRegistrationModel userRegistrationModel) {
        try {
            return ResponseEntity.ok(userService.addNewUser(userRegistrationModel));
        } catch (DuplicateEntryException | BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(path = "/authentication")
    public ResponseEntity authentication(@RequestBody AuthenticationModel authenticationModel) {
        try {
            Validator.validate(authenticationModel);
            Authentication authenticate =
                    authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authenticationModel.getEmail(), authenticationModel.getPassword()));
            String token = jwtUtil.createToken(userService.loadUserByEmail(authenticationModel.getEmail()));
            Map<String, Object> response = new java.util.HashMap<>(Map.of("token:", token));
            if (Objects.equals(authenticationModel.getRole(), "USER")) {
                response.putAll((new UserResponseModel(userService.loadUserByEmail(authenticationModel.getEmail()))).toMap());
            } else if (Objects.equals(authenticationModel.getRole(), "PATIENT")) {
                response.putAll((new PatientResponseModel(patientService.loadPatientByEmail(authenticationModel.getEmail()))).toMap());
            } else if (Objects.equals(authenticationModel.getRole(), "DOCTOR")) {
                response.putAll((new DoctorResponseModel(doctorService.loadDoctorByEmail(authenticationModel.getEmail()))).toMap());
            }
            return ResponseEntity.ok(response);
        } catch (BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(path = "/securityTest")
    public ResponseEntity securityTest() {
        try {
            return ResponseEntity.ok("Security success!!!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping(path = "/patientRegistration")
    public ResponseEntity addNewPatient(@RequestBody PatientRegistrationModel patientRegistrationModel) {
        try {
            return ResponseEntity.ok(patientService.addNewPatient(patientRegistrationModel));
        } catch (DuplicateEntryException | BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }
}
