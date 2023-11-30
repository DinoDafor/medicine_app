package su.ezhidze.server.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.model.InputMessageModel;
import su.ezhidze.server.service.ChatService;

@Entity
@Getter
@Setter
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    private Chat chat;

    private String messageText;

    public Message(final InputMessageModel inputMessageModel, ChatService chatService) {
        chat = chatService.getChatById(inputMessageModel.getChatId());
        messageText = inputMessageModel.getMessageText();
    }

    public Message() {
    }
}
