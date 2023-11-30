package su.ezhidze.server.repository;

import org.springframework.data.repository.CrudRepository;
import su.ezhidze.server.entity.Message;

public interface MessageRepository extends CrudRepository<Message, Integer> {

}
