package su.ezhidze.server.chat;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {
    @MessageMapping("/chat/{topic}")
    @SendTo("/topic/messages")
    public void send(@DestinationVariable("topic") String topic, Message message) throws Exception {
        System.out.println(message.getText());
    }
}
