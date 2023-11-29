package su.ezhidze.server.WebSocket;

import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import su.ezhidze.server.entity.Doctor;
import su.ezhidze.server.entity.Patient;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.repository.DoctorRepository;
import su.ezhidze.server.repository.PatientRepository;
import su.ezhidze.server.service.DoctorService;
import su.ezhidze.server.service.PatientService;
import su.ezhidze.server.util.JwtUtil;

@Component
@Slf4j
@RequiredArgsConstructor
public class WebSocketEventListener {

    private final SimpMessageSendingOperations messagingTemplate;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        String userUuid = event.getUser().getName();
        if (doctorRepository.findByUUID(userUuid).isPresent()) {
            Doctor doctor = doctorRepository.findByUUID(userUuid).orElseThrow(() -> new RecordNotFoundException("Doctor not found"));
            doctor.setIsOnline(false);
            doctor.setUUID(null);
            doctorRepository.save(doctor);
        } else if (patientRepository.findByUUID(userUuid).isPresent()) {
            Patient patient = patientRepository.findByUUID(userUuid).orElseThrow(() -> new RecordNotFoundException("Patient not found"));
            patient.setIsOnline(false);
            patient.setUUID(null);
            patientRepository.save(patient);
        }
    }

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        JwtUtil jwtUtil = new JwtUtil();
        String userUuid = event.getUser().getName();
        String bearerToken = UserHandshakeHandler.lastHttpHeaders.get("Authorization").get(0);
        String tokenPrefix = "Bearer ";
        String jwtToken = null;
        if (bearerToken != null && bearerToken.startsWith(tokenPrefix)) jwtToken = bearerToken.substring(tokenPrefix.length());
        Claims claims = jwtUtil.parseJwtClaims(jwtToken);
        if (claims.get("role").equals("PATIENT")) {
            Patient patient = patientService.loadPatientByEmail(claims.getSubject());
            patient.setUUID(userUuid);
            patient.setIsOnline(true);
            patientRepository.save(patient);
        } else if (claims.get("role").equals("DOCTOR")) {
            Doctor doctor = doctorService.loadDoctorByEmail(claims.getSubject());
            doctor.setUUID(userUuid);
            doctor.setIsOnline(true);
            doctorRepository.save(doctor);
        }
    }
}
