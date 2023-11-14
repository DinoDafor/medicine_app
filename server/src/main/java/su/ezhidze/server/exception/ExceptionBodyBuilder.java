package su.ezhidze.server.exception;

import java.util.Map;

public class ExceptionBodyBuilder {

    public static Map build(Integer status, String reason) {
        return Map.of("status", status, "reason", reason);
    }

}
