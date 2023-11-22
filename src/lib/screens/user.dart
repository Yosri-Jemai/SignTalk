class User {
  final String firstName;
  final String lastName;
  final bool talker;

  late final List<User> friends;

  User(this.firstName, this.lastName, this.talker) {
    friends = [];
  }
}
