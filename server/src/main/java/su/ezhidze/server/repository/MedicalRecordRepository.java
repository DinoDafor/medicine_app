package su.ezhidze.server.repository;

import org.springframework.data.repository.CrudRepository;
import su.ezhidze.server.entity.MedicalRecord;

public interface MedicalRecordRepository extends CrudRepository<MedicalRecord, Integer> {
}
