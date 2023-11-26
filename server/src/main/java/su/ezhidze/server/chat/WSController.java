package su.ezhidze.server.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class WSController {
    @Autowired
    private WSService service;

    @PostMapping("/send-message")
    public void sendMessage(@RequestBody final Message message) {
        service.notifyFrontend(message.getText());
    }

    @PostMapping("/send-private-message")
    public void sendPrivateMessage(@RequestParam final String id,
                                   @RequestBody final Message message) {
        service.notifyUser(id, message.getText());
    }
}
