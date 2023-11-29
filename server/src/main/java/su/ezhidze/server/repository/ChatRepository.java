package su.ezhidze.server.repository;

import org.springframework.data.repository.CrudRepository;
import su.ezhidze.server.entity.Chat;

public interface ChatRepository extends CrudRepository<Chat, Integer> {
}
