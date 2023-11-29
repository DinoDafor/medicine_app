package su.ezhidze.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import su.ezhidze.server.exception.ExceptionBodyBuilder;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.InputMessageModel;
import su.ezhidze.server.service.ChatService;
import su.ezhidze.server.service.WSService;
import su.ezhidze.server.validator.Validator;

import java.security.Principal;

@Controller
public class ChatController {

    @Autowired
    private WSService service;

    @Autowired
    private ChatService chatService;

    @MessageMapping("/private-chat")
    @SendToUser("/topic/private-messages")
    public InputMessageModel getPrivateMessage(final InputMessageModel message, final Principal principal) throws Exception {
        Validator.validate(message);
        service.sendMessage(message);
        return message;
    }

    @PostMapping(path = "/addChat")
    public ResponseEntity addNewCinema() {
        try {
            return ResponseEntity.ok(chatService.addNewChat());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(path = "/chats")
    public ResponseEntity getChats() {
        try {
            return ResponseEntity.ok(chatService.getChats());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @GetMapping(path = "/chats", params = {"id"})
    public ResponseEntity getChats(@RequestParam Integer id) {
        try {
            return ResponseEntity.ok(chatService.getChatById(id));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @PutMapping(path = "/addUser")
    public ResponseEntity addUser(@RequestParam Integer chatId, @RequestParam Integer userId, @RequestParam String role) {
        try {
            return ResponseEntity.ok(chatService.addUser(chatId, userId, role));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }

    @PutMapping(path = "/deleteUser")
    public ResponseEntity deleteUser(@RequestParam Integer chatId, @RequestParam Integer userId, @RequestParam String role) {
        try {
            return ResponseEntity.ok(chatService.deleteUser(chatId, userId, role));
        } catch (RecordNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ExceptionBodyBuilder.build(HttpStatus.NOT_FOUND.value(), e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ExceptionBodyBuilder.build(HttpStatus.BAD_REQUEST.value(), e.getMessage()));
        }
    }
}
