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
import su.ezhidze.server.entity.User;
import su.ezhidze.server.exception.BadArgumentException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.ExceptionBodyBuilder;
import su.ezhidze.server.model.AuthenticationModel;
import su.ezhidze.server.service.UserService;
import su.ezhidze.server.util.JwtUtil;

@Controller
@RequestMapping
public class MainController {

    private final AuthenticationManager authenticationManager;

    private JwtUtil jwtUtil;

    @Autowired
    private UserService userService;

    public MainController(AuthenticationManager authenticationManager, JwtUtil jwtUtil) {
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping(path = "/registration")
    public ResponseEntity addNewUser(@RequestBody User user) {
        try {
            return ResponseEntity.ok(userService.addNewUser(user));
        } catch (DuplicateEntryException | BadArgumentException e) {
            return ResponseEntity.internalServerError().body(ExceptionBodyBuilder.build(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(path = "/authentication")
    public ResponseEntity authentication(@RequestBody AuthenticationModel authenticationModel) {
        try {
            Authentication authenticate =
                    authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authenticationModel.getEmail(), authenticationModel.getPassword()));
            String token = jwtUtil.createToken(userService.findUserByEmail(authenticationModel.getEmail()));
            return ResponseEntity.ok(token);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
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

}

