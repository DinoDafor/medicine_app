package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.entity.Message;

@Getter
@Setter
public class MessageResponseModel {

    private Integer id;

    private Integer chatId;

    private String messageText;

    public MessageResponseModel(final Message message) {
        id = message.getId();
        chatId = message.getChat().getId();
        messageText = message.getMessageText();
    }
}
