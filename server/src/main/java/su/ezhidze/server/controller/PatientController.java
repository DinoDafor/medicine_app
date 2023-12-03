package su.ezhidze.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import su.ezhidze.server.exception.BadArgumentException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.ExceptionBodyBuilder;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.AuthenticationModel;
import su.ezhidze.server.model.PatientRegistrationModel;
import su.ezhidze.server.model.PatientResponseModel;
import su.ezhidze.server.service.PatientService;
import su.ezhidze.server.util.JwtUtil;
import su.ezhidze.server.validator.Validator;

import java.util.Map;

@Controller
@RequestMapping(path = "/medApp/patients")
public class PatientController {

    private final AuthenticationManager authenticationManager;
    @Autowired
    private PatientService patientService;
    private JwtUtil jwtUtil;

    public PatientController(AuthenticationManager authenticationManager, JwtUtil jwtUtil) {
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping(path = "/registration")
    public ResponseEntity addNewDoctor(@RequestBody PatientRegistrationModel patientRegistrationModel) {
        try {
            return ResponseEntity.ok(patientService.addNewPatient(patientRegistrationModel));
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
            String token = jwtUtil.createToken(patientService.loadPatientByEmail(authenticationModel.getEmail()));
            Map<String, Object> response = new java.util.HashMap<>(Map.of("token:", token));
            response.putAll((new PatientResponseModel(patientService.loadPatientByEmail(authenticationModel.getEmail()))).toMap());
            return ResponseEntity.ok(response);
        } catch (BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping
    public ResponseEntity getPatients() {
        try {
            return ResponseEntity.ok(patientService.getPatients());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(params = {"id"})
    public ResponseEntity getPatientById(@RequestParam Integer id) {
        try {
            return ResponseEntity.ok(new PatientResponseModel(patientService.getPatientById(id)));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @DeleteMapping(path = "/delete")
    public ResponseEntity deletePatient(@RequestParam Integer id) {
        try {
            patientService.delete(id);
            return ResponseEntity.accepted().build();
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @PatchMapping(path = "/patch")
    public ResponseEntity patchPatient(@RequestParam Integer id, @RequestBody Map<String, Object> fields) {
        try {
            return ResponseEntity.ok(patientService.patch(id, fields));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (DuplicateEntryException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }
}
