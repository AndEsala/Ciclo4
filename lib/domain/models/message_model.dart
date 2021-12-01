import 'package:red_egresados/domain/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unRead;

  Message(
      {required this.sender,
      required this.time,
      required this.text,
      required this.isLiked,
      required this.unRead});
}

//MY current user
final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/images/ceci.jpg',
);

//Users
final User ronald = User(
  id: 1,
  name: 'Ronald Ruiz',
  imageUrl: 'assets/images/ronald.jpg',
);
final User maria = User(
  id: 2,
  name: 'Maria cuadros',
  imageUrl: 'assets/images/maria.jpg',
);

final User elizabeth = User(
  id: 3,
  name: 'Elizabeth tapia',
  imageUrl: 'assets/images/elizabeth.jpg',
);
//favorites users

List<User> favorites = [ronald, maria, elizabeth];

List<Message> chats = [
  Message(
    sender: maria,
    time: '5:30pm',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unRead: false,
  ),
  Message(
    sender: elizabeth,
    time: '5:30pm',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unRead: true,
  ),
  Message(
    sender: ronald,
    time: '5:30pm',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unRead: false,
  ),
];
// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: maria,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unRead: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unRead: true,
  ),
  Message(
    sender: maria,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unRead: true,
  ),
  Message(
    sender: maria,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unRead: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unRead: true,
  ),
  Message(
    sender: maria,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unRead: true,
  ),
];
