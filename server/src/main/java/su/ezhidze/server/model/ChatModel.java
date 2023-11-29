package su.ezhidze.server.model;

import lombok.Getter;
import lombok.Setter;
import su.ezhidze.server.entity.Chat;

import java.util.List;

@Getter
@Setter
public class ChatModel {

    private Integer id;

    private List<UserResponseModel> users;

    private List<MessageResponseModel> messages;

    public ChatModel(final Chat chat) {
        id = chat.getId();
        users = chat.getUsers().stream().map(UserResponseModel::new).toList();
        messages = chat.getMessages().stream().map(MessageResponseModel::new).toList();
    }
}
