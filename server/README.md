# medApp server

### **http://ezhidze.su:8080**

## Http запросы:

### Doctor controller - http://ezhidze.su:8080/medApp/doctors

* #### http://ezhidze.su:8080/medApp/doctors/registration

  PostMapping, зарегистрировать нового доктора

  Json тело запроса должно содержать поля:
  * String firstName
  * String lastName
  * String String email
  * String password
  * String specialization
  * String contactNumber
  * String clinicAddress
  * String otherRelevantInfo

  Пример: 
  `{
  "firstName": "Artyom",
  "lastName": "Tsatinyan",
  "email": "doctor1@gmail.com",
  "password": "NYVzp#n9Z727",
  "specialization": "paramedic",
  "contactNumber": "6545648974",
  "clinicAddress": "goihdgopre",
  "otherRelevantInfo": "osafjgjsr"    
  }`

* #### http://ezhidze.su:8080/medApp/doctors/authentication
  
  GetMapping, аутентификация пользователя

  Json тело запроса должно содержать поля:
  * String email
  * String password
  
  Пример:
  `{
  "email": "doctor1@gmail.com",
  "password": "NYVzp#n9Z727"
  }`
 
  Вернёт тело сущности и jwt token

* #### http://ezhidze.su:8080/medApp/doctors

  GetMapping, вернёт список всех докторов

* #### http://ezhidze.su:8080/medApp/doctors

  GetMapping, получить доктора по id

  Параметры: **Integer id**

  Пример: http://ezhidze.su:8080/medApp/doctors?id=752

* #### http://ezhidze.su:8080/medApp/doctors/delete

  DeleteMapping, удалить доктора по id

  Параметры: **Integer id**

  Пример: http://ezhidze.su:8080/medApp/doctors/delete?id=652

* #### http://ezhidze.su:8080/medApp/doctors/patch

  PatchMapping, изменить тело сущности

  Параметры: **Integer id**

  Json тело запроса должно содержать те поля, которые вы хотите изменить

  Пример: http://ezhidze.su:8080/medApp/doctors/patch?id=752

  `{
  "firstName": "Saul",
  "lastName": "Goodman"
  }`

  Вернёт изменённое тело сущности

### Patient controller - http://ezhidze.su:8080/medApp/patients

* #### http://ezhidze.su:8080/medApp/patients/registration

  PostMapping, зарегистрировать нового пациента

  Json тело запроса должно содержать поля:
    * String firstName
    * String lastName
    * String String email
    * String password
    * String dateOfBirth
    * String gender
    * String contactNumber
    * String address
    * String otherRelevantInfo

  Пример:
  `{
  "firstName": "Artyom",
  "lastName": "Tsatinyan",
  "email": "patinent2@gmail.com",
  "password": "NYVzp#n9Z727",
  "dateOfBirth": "19.11.2023",
  "gender": "male",
  "contactNumber": "91321321311",
  "address": "dsdsdasd",
  "otherRelevantInfo": "dsdadsjfwefj"
  }`

* #### http://ezhidze.su:8080/medApp/patients/authentication

  GetMapping, аутентификация пользователя

  Json тело запроса должно содержать поля:
    * String email
    * String password

  Пример:
  `{
  "email": "patinent2@gmail.com",
  "password": "NYVzp#n9Z727"
  }`

  Вернёт тело сущности и jwt token

* #### http://ezhidze.su:8080/medApp/patients

  GetMapping, вернёт список всех пациентов

* #### http://ezhidze.su:8080/medApp/patients

  GetMapping, получить пациента по id

  Параметры: **Integer id**

  Пример: http://ezhidze.su:8080/medApp/patients?id=802

* #### http://ezhidze.su:8080/medApp/patients/delete

  DeleteMapping, удалить пациента по id

  Параметры: **Integer id**

  Пример: http://ezhidze.su:8080/medApp/patients/delete?id=652

* #### http://ezhidze.su:8080/medApp/patients/patch

  PatchMapping, изменить тело сущности

  Параметры: **Integer id**

  Json тело запроса должно содержать те поля, которые вы хотите изменить

  Пример: http://ezhidze.su:8080/medApp/patients/patch?id=752

  `{
  "firstName": "Saul",
  "lastName": "Goodman"
  }`

  Вернёт изменённое тело сущности

### Chat controller - http://ezhidze.su:8080/

* #### http://ezhidze.su:8080/chats 
  GetMapping, получить список всех чатов
* #### http://ezhidze.su:8080/chats 

    GetMapping, получить чат по id

    Параметры: **Integer id**~~~~

    Пример: http://ezhidze.su:8080/chats?id=0
* #### http://ezhidze.su:8080/addChat 
  PostMapping, добавить чат, вызвывается без параметров, в ответ сервер просто вернёт пустое тело чата с его id
* #### http://ezhidze.su:8080/joinUser 

  PutMapping, добавить пользователся в чат

  Параметры: **Integer chatId, Integer userId, String role**

  role: **PATIENT, DOCTOR**

  Пример: http://ezhidze.su:8080/joinUser?chatId=1&userId=1&role=PATIENT

* #### http://ezhidze.su:8080/deleteUser
  PutMapping, удалить пользователя из чата
  
  Параметры: **Integer chatId, Integer userId, String role**

  role: **PATIENT, DOCTOR**

  Пример: http://ezhidze.su:8080/deleteUser?chatId=2&userId=802&role=PATIENT
* #### http://ezhidze.su:8080/deleteMessage
  PutMapping, удалить сообщение из чата

  Параметры: **Integer chatId, Integer messageId**

  Пример: http://ezhidze.su:8080/deleteMessage?chatId=1&messageId=152

# WebSockets

### ws://ezhidze.su:8080/chat

Логика работы следующая: клиентская часть посылает сообщение в определённый чат(id чата отправляется вместе с объектом message).
Далее сервер рассылает это сообщение всем участникам чата, которые в данный момент онлайн. Далее сервер сохраняет сообщение в чате, для того чтобы клиенты, которые выйдут из состояния офлайн, смогли запросить новые сообщения.
Соответственно если нужно отправить сообщение от одного пользователя другому, то вы создаёте новый чат(если кончено уже не было чата для этих пользователей), добавляете туда пользователей и отправляете ваше сообщение в этот чат,
дальше сервер сам разошлёт сообщение онлайн пользователям и сохранит его для тех кто офлайн на жанный момент.

Для присоединения нужно использовать sockJs

Отправляются сообщения по пути `"/app/private-chat"`

В хедерах запроса должен быть хедер `Authorization` со значением вида `Bearer ...` где вместо `...` должен быть jwt токен клиента

Как сообщение сервер ожидает получить объект класса со следующими полями:

`String senderSubject; Integer chatId; String messageText`

Для получения сообщений нужно подписать клиента на `"/user/topic/private-messages"`

Пример класса сообщений и клиентской части на Java

```java
public class InputMessageModel {

    private String senderSubject;

    private Integer chatId;

    private String messageText;

    public InputMessageModel(String senderSubject, Integer chatId, String messageText) {
        this.senderSubject = senderSubject;
        this.chatId = chatId;
        this.messageText = messageText;
    }

    public InputMessageModel() {
    }

    public String getSenderSubject() {
        return senderSubject;
    }

    public void setSenderSubject(String senderSubject) {
        this.senderSubject = senderSubject;
    }

    public Integer getChatId() {
        return chatId;
    }

    public void setChatId(Integer chatId) {
        this.chatId = chatId;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }
}
```

```java
public class ChatClient {
    public static void main(String args[]) throws Exception {
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        String url = "ws://ezhidze.su:8080/chat"; //Url для подключения к серверу
        WebSocketClient client = new StandardWebSocketClient();
        List<Transport> transports = new ArrayList<>(1);
        transports.add(new WebSocketTransport(client));
        SockJsClient sockJsClient = new SockJsClient(transports); //Создаём sockJs клиент

        WebSocketStompClient stompClient = new WebSocketStompClient(sockJsClient);
        stompClient.setMessageConverter(new MappingJackson2MessageConverter());

        StompSessionHandler sessionHandler = new MyStompSessionHandler();
        WebSocketHttpHeaders webSocketHttpHeaders = new WebSocketHttpHeaders();
        System.out.println("jwt token:");
        webSocketHttpHeaders.add("Authorization", "Bearer " + in.readLine()); //Добавляем хедер с токеном
        StompSession session = stompClient.connect(url, webSocketHttpHeaders, sessionHandler).get(); //Присоединяемся к серверу

        System.out.println("Our email: ");
        String email = in.readLine();
        System.out.println("Chat id: ");
        Integer chatID = Integer.valueOf(in.readLine());
        for (; ; ) {
            String line = in.readLine();
            if (line == null) break;
            if (line.isEmpty()) continue;
            InputMessageModel msg = new InputMessageModel(); //Создаем объект класса сообщений и инициализируем его поля
            msg.setChatId(chatID);
            msg.setSenderSubject(email);
            msg.setMessageText(line);
            session.send("/app/private-chat", msg); //Отправляем сообщение на сервер в чат
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
            session.subscribe("/user/topic/private-messages", this); //Подписываемся на получение сообщений
        }
    }
}
```