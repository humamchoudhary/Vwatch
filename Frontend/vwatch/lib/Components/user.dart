class User{
  String username;
  List profiles;
  String token;
  User({required this.profiles,required this.username, required this.token});

}

class Profile {
  String username;
  List history;
  List watchQueue;
  String img;
  Profile({required this.history,required this.username,required this.watchQueue,required this.img});
}