package su.ezhidze.server.chat;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class OutputMessage {
    private String from;
    private String message;
    private String topic;
    private Date time = new Date();

    public OutputMessage(String from, String message, String topic) {
        this.from = from;
        this.message = message;
        this.topic = topic;
    }
}
