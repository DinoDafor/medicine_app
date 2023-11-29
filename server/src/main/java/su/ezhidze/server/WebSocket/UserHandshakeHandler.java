package su.ezhidze.server.WebSocket;

import com.sun.security.auth.UserPrincipal;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;
import su.ezhidze.server.entity.Doctor;
import su.ezhidze.server.entity.Patient;
import su.ezhidze.server.repository.PatientRepository;
import su.ezhidze.server.service.DoctorService;
import su.ezhidze.server.service.PatientService;
import su.ezhidze.server.util.JwtUtil;

import java.security.Principal;
import java.util.Map;
import java.util.UUID;

public class UserHandshakeHandler extends DefaultHandshakeHandler {

    public static HttpHeaders lastHttpHeaders;

    @Override
    protected Principal determineUser(ServerHttpRequest request, WebSocketHandler wsHandler, Map<String, Object> attributes) {
        final String randomId = UUID.randomUUID().toString();
        lastHttpHeaders = request.getHeaders();

        System.out.println(randomId);
        return new UserPrincipal(randomId);
    }
}
