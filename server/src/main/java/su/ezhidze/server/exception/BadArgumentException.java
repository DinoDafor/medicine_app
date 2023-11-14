package su.ezhidze.server.exception;

public class BadArgumentException extends RuntimeException {
    public BadArgumentException(String message) {
        super(message);
    }
}
