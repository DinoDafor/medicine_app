package su.ezhidze.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import su.ezhidze.server.entity.User;
import su.ezhidze.server.exception.AuthenticationFailException;
import su.ezhidze.server.exception.BadArgumentException;
import su.ezhidze.server.exception.DuplicateEntryException;
import su.ezhidze.server.exception.ExceptionBodyBuilder;
import su.ezhidze.server.model.AuthenticationModel;
import su.ezhidze.server.service.UserService;

@Controller
@RequestMapping(path="/medApp")
public class MainController {
    @Autowired
    private UserService userService;

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
    public ResponseEntity getUserData(@RequestBody AuthenticationModel authenticationModel) {
        try {
            return ResponseEntity.ok(userService.getUserData(authenticationModel));
        } catch (AuthenticationFailException e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.UNAUTHORIZED.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }
}
