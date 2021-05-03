class Spacecraft {
  String name;
  DateTime? launchDate;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  int? get launchYear => launchDate?.year; // read-only non-final property

  // Method.
  String describe() {
    var description = 'I am a Spacecraft called: $name';
    print(description);
    var launchDate = this.launchDate; // Type promotion doesn't work on getters.
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
    return description;
  }

  int takeOff(int mins) {
    print(" I will take off in $mins mins");
    return 0;
  }
}
