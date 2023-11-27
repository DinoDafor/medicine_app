package sample;

import lombok.Getter;
import lombok.Setter;

/*
 * Message sent to server.
 *
 * @Author Jay Sridhar
 */
public class Message {

    private String from;

    private String text;

    private String receiverUuid;

    public Message() {
    }

    public Message(String from, String text) {
        this.from = from;
        this.text = text;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getReceiverUuid() {
        return receiverUuid;
    }

    public void setReceiverUuid(String receiverUuid) {
        this.receiverUuid = receiverUuid;
    }
}
