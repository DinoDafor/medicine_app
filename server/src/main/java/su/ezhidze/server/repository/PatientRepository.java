package su.ezhidze.server.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import su.ezhidze.server.entity.Patient;

import java.util.Optional;

@Repository
public interface PatientRepository extends CrudRepository<Patient, Integer> {
    Optional<Patient> findByEmail(String email);
}
