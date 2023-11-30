package su.ezhidze.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import su.ezhidze.server.entity.Message;
import su.ezhidze.server.exception.RecordNotFoundException;
import su.ezhidze.server.model.InputMessageModel;
import su.ezhidze.server.model.MessageResponseModel;
import su.ezhidze.server.repository.MessageRepository;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    public MessageResponseModel addNewMessage(InputMessageModel inputMessageModel, ChatService chatService) {
        Message m = new Message(inputMessageModel, chatService);
        return new MessageResponseModel(messageRepository.save(m));
    }

    public Message getMessageById(Integer id) {
        return messageRepository.findById(id).orElseThrow(() -> new RecordNotFoundException("Message not found"));
    }
}
