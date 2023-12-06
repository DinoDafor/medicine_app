package su.ezhidze.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import su.ezhidze.server.exception.BadArgumentException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.ExceptionBodyBuilder;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.MedicalRecordResponseModel;
import su.ezhidze.server.model.MedicalRecordRegistrationModel;
import su.ezhidze.server.service.MedicalRecordService;

import java.util.Map;

@Controller
@RequestMapping(path = "/medApp/medicalRecords")
public class MedicalRecordController {

    @Autowired
    private MedicalRecordService medicalRecordService;

    @GetMapping
    public ResponseEntity getMedicalRecords() {
        try {
            return ResponseEntity.ok(medicalRecordService.getMedicalRecords());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(params = {"id"})
    public ResponseEntity getMedicalRecordById(@RequestParam Integer id) {
        try {
            return ResponseEntity.ok(new MedicalRecordResponseModel(medicalRecordService.getMedicalRecordById(id)));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @PostMapping(path = "/add")
    public ResponseEntity addNewMedicalRecord(@RequestBody MedicalRecordRegistrationModel medicalRecordModel) {
        try {
            return ResponseEntity.ok(medicalRecordService.addNewMedicalRecord(medicalRecordModel));
        } catch (DuplicateEntryException | BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @PatchMapping(path = "/patch")
    public ResponseEntity patchMedicalRecord(@RequestParam Integer id, @RequestBody Map<String, Object> fields) {
        try {
            return ResponseEntity.ok(medicalRecordService.patch(id, fields));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @DeleteMapping(path = "/delete")
    public ResponseEntity deleteMedicalRecord(@RequestParam Integer id) {
        try {
            medicalRecordService.delete(id);
            return ResponseEntity.accepted().build();
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }
}
