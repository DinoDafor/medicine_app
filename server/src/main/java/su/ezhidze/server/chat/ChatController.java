package su.ezhidze.server.chat;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class ChatController {
    @MessageMapping("/chat")
    @SendTo("/topic/messages")
    public OutputMessage getMessage(Message message) throws Exception {
        String time = new SimpleDateFormat("HH:mm").format(new Date());
        System.out.println(message.getText());
        return new OutputMessage("", message.getText(), time);
    }

    @MessageMapping("/private-chat")
    @SendToUser("/topic/private-messages")
    public OutputMessage getPrivateMessage(Message message, final Principal principal) throws Exception {
        String time = new SimpleDateFormat("HH:mm").format(new Date());
        System.out.println(message.getText());
        return new OutputMessage("", "private message to user " + principal.getName() + ": " + message.getText(), time);
    }
}
