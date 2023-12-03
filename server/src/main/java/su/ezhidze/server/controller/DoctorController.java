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
import su.ezhidze.server.model.*;
import su.ezhidze.server.service.DoctorService;
import su.ezhidze.server.util.JwtUtil;
import su.ezhidze.server.validator.Validator;

import java.util.Map;

@Controller
@RequestMapping(path = "/medApp/doctors")
public class DoctorController {

    @Autowired
    private DoctorService doctorService;

    private final AuthenticationManager authenticationManager;

    private JwtUtil jwtUtil;

    public DoctorController(AuthenticationManager authenticationManager, JwtUtil jwtUtil) {
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping(path = "/registration")
    public ResponseEntity addNewDoctor(@RequestBody DoctorRegistrationModel doctorRegistrationModel) {
        try {
            return ResponseEntity.ok(doctorService.addNewDoctor(doctorRegistrationModel));
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
            String token = jwtUtil.createToken(doctorService.loadDoctorByEmail(authenticationModel.getEmail()));
            Map<String, Object> response = new java.util.HashMap<>(Map.of("token:", token));
            response.putAll((new DoctorResponseModel(doctorService.loadDoctorByEmail(authenticationModel.getEmail()))).toMap());
            return ResponseEntity.ok(response);
        } catch (BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping
    public ResponseEntity getDoctors() {
        try {
            return ResponseEntity.ok(doctorService.getDoctors());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(params = {"id"})
    public ResponseEntity getDoctorById(@RequestParam Integer id) {
        try {
            return ResponseEntity.ok(new DoctorResponseModel(doctorService.getDoctorById(id)));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @DeleteMapping(path = "/delete")
    public ResponseEntity deleteDoctor(@RequestParam Integer id) {
        try {
            doctorService.delete(id);
            return ResponseEntity.accepted().build();
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @PatchMapping(path = "/patch")
    public ResponseEntity patchMovie(@RequestParam Integer id, @RequestBody Map<String, Object> fields) {
        try {
            return ResponseEntity.ok(doctorService.patch(id, fields));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (DuplicateEntryException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

}
