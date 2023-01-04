class User{
  String username;
  List profiles;
  User({required this.profiles,required this.username});

}

class Profile {
  String username;
  List history;
  List watchQueue;
  Profile({required this.history,required this.username,required this.watchQueue});
}