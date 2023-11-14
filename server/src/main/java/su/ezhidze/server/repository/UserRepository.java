package su.ezhidze.server.repository;

import org.springframework.stereotype.Repository;
import su.ezhidze.server.entity.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {
    Optional<User> findByEmail(String email);
}
