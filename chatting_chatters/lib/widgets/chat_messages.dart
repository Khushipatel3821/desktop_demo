import 'package:chatting_chatters/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    print("Current Authenticated User : $authenticatedUser");

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapShots) {
          if (chatSnapShots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapShots.hasData || chatSnapShots.data!.docs.isEmpty) {
            return const Center(
              child: Text("No messages found."),
            );
          }

          if (chatSnapShots.hasError) {
            return const Center(
              child: Text("Something went wrong..."),
            );
          }
          final loadedMessages = chatSnapShots.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {
              final chatMessage = loadedMessages[index].data();
              final currentMessageUserId = chatMessage["userId"];

              final isMe = (authenticatedUser.uid == currentMessageUserId);
              final nextChatMessage = ((index + 1) < loadedMessages.length)
                  ? loadedMessages[index + 1].data()
                  : null;

              final nextMessageUserId =
                  (nextChatMessage != null) ? nextChatMessage["userId"] : null;
              final nextUserIsSame =
                  (nextMessageUserId == currentMessageUserId);

              if (nextUserIsSame) {
                return MessageBubble.next(
                    message: chatMessage["text"],
                    isMe: isMe);
              } else {
                return MessageBubble.first(
                    userImage: chatMessage["userImage"],
                    username: chatMessage["username"],
                    message: chatMessage["text"],
                    isMe: isMe);
              }
            },
          );
        });
  }
}
