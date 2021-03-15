import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Future<void> addUserInfo(userData) async {
  //   Firestore.instance.collection("users").add(userData).catchError((e) {
  //     print(e.toString());
  //   });
  // }
  //
  // getUserInfo(String name) async {
  //   return await Firestore.instance
  //       .collection("users")
  //       .where("name", isEqualTo: name)
  //       .getDocuments()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }
  createChat(String chatRoomId,MapchatRomm) async{
   Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(MapchatRomm).catchError((e) {
     print(e.toString());
   });
}

addChats(String chatRoomId,MassegeMap) async{
  return Firestore.instance
      .collection("ChatRoom").document(chatRoomId).collection("chat")
      .add(MassegeMap).catchError((e) {print(e.toString());});
}
  getChats(String chatRoomId) async{
    return await Firestore.instance
        .collection("ChatRoom").document(chatRoomId).collection("chat").orderBy("time",descending: false)
        .snapshots();
  }

  getChatsMe(String username) async{
    return await Firestore.instance
        .collection("ChatRoom").where("users",arrayContains :username).snapshots();
  }

// searchByName(String searchField) {
//   return Firestore.instance
//       .collection("users")
//       .where('userName', isEqualTo: searchField)
//       .getDocuments();
// }

// Future<bool> addChatRoom(chatRoom, chatRoomId) {
//   Firestore.instance
//       .collection("chatRoom")
//       .document(chatRoomId)
//       .setData(chatRoom)
//       .catchError((e) {
//     print(e);
//   });
// }


// Future<void> addMessage(String chatRoomId, chatMessageData){
//
//   Firestore.instance.collection("chatRoom")
//       .document(chatRoomId)
//       .collection("chats")
//       .add(chatMessageData).catchError((e){
//     print(e.toString());
//   });
// }

// getUserChats(String itIsMyName) async {
//   return await Firestore.instance
//       .collection("chatRoom")
//       .where('users', arrayContains: itIsMyName)
//       .snapshots();
// }

}