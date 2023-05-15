package com.chatServer.charServer.controller;

import com.chatServer.charServer.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

//    resive los datos para el grupo
//    y envia los datos para el grupo 
//    (minuto: 12:30)
    @MessageMapping("/message")// recive el mensaje -> /app/message "app" es de "WebSocketConfig"
    @SendTo("/chatroom/public")// envia el mensaje 
    public Message receiveMessage(@Payload Message message) {
        return message;
    }

    @MessageMapping("/private-message")// recive el mensaje en privado 
    public Message recMessage(@Payload Message message) {
//       "simpMessagingTemplate" toma automaticamente el prefijo "/user" de "WebSocketConfig"
        simpMessagingTemplate.convertAndSendToUser(message.getReceiverName(), "/private", message);// envia el mensaje en privado -> /user/Juan/private/{mensaje}
        System.out.println(message.toString());
        return message;
    }
}
