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

        String url = "ws://localhost:8080/chat";
        WebSocketClient client = new StandardWebSocketClient();
        List<Transport> transports = new ArrayList<>(1);
        transports.add(new WebSocketTransport(client));
        SockJsClient sockJsClient = new SockJsClient(transports);

        WebSocketStompClient stompClient = new WebSocketStompClient(sockJsClient);
        stompClient.setMessageConverter(new MappingJackson2MessageConverter());

        StompSessionHandler sessionHandler = new MyStompSessionHandler();
        WebSocketHttpHeaders webSocketHttpHeaders = new WebSocketHttpHeaders();
        webSocketHttpHeaders.add("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZDM0MzI0c0BnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJBcnR5b20iLCJsYXN0TmFtZSI6IlRzYXRpbnlhbiIsImV4cCI6MTkxNzExMTg2OX0.bxIaESjCbJq3we5F4FLzuEJI2fco0n509Uk26ZMEyWc");
        StompSession session = stompClient.connect(url, webSocketHttpHeaders, sessionHandler).get();

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        for (; ; ) {
            String receiverUuid = in.readLine(), line = in.readLine();
            if (line == null) break;
            if (line.isEmpty()) continue;
            Message msg = new Message("user", line);
            msg.setReceiverUuid(receiverUuid);
            session.send("/app/private-chat", msg);
        }
    }

    static public class MyStompSessionHandler extends StompSessionHandlerAdapter {

        @Override
        public Type getPayloadType(StompHeaders headers) {
            return Message.class;
        }

        @Override
        public void handleFrame(StompHeaders headers, Object payload) {
            Message msg = (Message) payload;
            System.out.println("Received : " + msg.getText() + " from : " + msg.getFrom());
        }

        private Message getSampleMessage() {
            Message msg = new Message();
            msg.setFrom("Nicky");
            msg.setText("Howdy!!");
            return msg;
        }

        @Override
        public void afterConnected(StompSession session, StompHeaders connectedHeaders) {
            session.subscribe("/topic/messages", this);
            session.subscribe("/user/topic/private-messages", this);
            session.send("/app/chat", getSampleMessage());
        }
    }
}
