package su.ezhidze.server.repository;

import org.springframework.data.repository.CrudRepository;
import su.ezhidze.server.entity.Doctor;

import java.util.Optional;

public interface DoctorRepository extends CrudRepository<Doctor, Integer> {
    Optional<Doctor> findByEmail(String email);
}
