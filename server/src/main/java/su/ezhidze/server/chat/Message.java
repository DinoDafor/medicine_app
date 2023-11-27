package su.ezhidze.server.chat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Message {

    private String from;

    private String text;

    private String receiverUuid;
}
