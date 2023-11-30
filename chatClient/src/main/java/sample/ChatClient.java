package sample;

import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.simp.stomp.StompHeaders;
import org.springframework.messaging.simp.stomp.StompSession;
import org.springframework.messaging.simp.stomp.StompSessionHandler;
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter;
import org.springframework.web.socket.WebSocketHttpHeaders;
import org.springframework.web.socket.client.WebSocketClient;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.messaging.WebSocketStompClient;
import org.springframework.web.socket.sockjs.client.SockJsClient;
import org.springframework.web.socket.sockjs.client.Transport;
import org.springframework.web.socket.sockjs.client.WebSocketTransport;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ChatClient {
    public static void main(String args[]) throws Exception {
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        String url = "ws://localhost:8080/chat";
        WebSocketClient client = new StandardWebSocketClient();
        List<Transport> transports = new ArrayList<>(1);
        transports.add(new WebSocketTransport(client));
        SockJsClient sockJsClient = new SockJsClient(transports);

        WebSocketStompClient stompClient = new WebSocketStompClient(sockJsClient);
        stompClient.setMessageConverter(new MappingJackson2MessageConverter());

        StompSessionHandler sessionHandler = new MyStompSessionHandler();
        WebSocketHttpHeaders webSocketHttpHeaders = new WebSocketHttpHeaders();
        System.out.println("jwt token:");
        webSocketHttpHeaders.add("Authorization", "Bearer " + in.readLine());
        StompSession session = stompClient.connect(url, webSocketHttpHeaders, sessionHandler).get();

        System.out.println("Our email: ");
        String email = in.readLine();
        System.out.println("Chat id: ");
        Integer chatID = Integer.valueOf(in.readLine());
        for (; ; ) {
            String line = in.readLine();
            if (line == null) break;
            if (line.isEmpty()) continue;
            InputMessageModel msg = new InputMessageModel();
            msg.setChatId(chatID);
            msg.setSenderSubject(email);
            msg.setMessageText(line);
            session.send("/app/private-chat", msg);
        }
    }

    static public class MyStompSessionHandler extends StompSessionHandlerAdapter {

        @Override
        public Type getPayloadType(StompHeaders headers) {
            return InputMessageModel.class;
        }

        @Override
        public void handleFrame(StompHeaders headers, Object payload) {
            InputMessageModel msg = (InputMessageModel) payload;
            System.out.println("Received : " + msg.getMessageText() + " from : " + msg.getSenderSubject());
        }

        @Override
        public void afterConnected(StompSession session, StompHeaders connectedHeaders) {
            session.subscribe("/topic/messages", this);
            session.subscribe("/user/topic/private-messages", this);
        }
    }
}
