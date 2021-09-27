# robotremoteserver_dart

A dart module providing the [robot framework](http://www.robotframework.org) remote library interface.

## Usage

A simple usage example that can control a Spacecraft remotely

```dart
//define Spacecraft class to be controlled remotely

class Spacecraft {
  String name;
  DateTime? launchDate;

  Spacecraft(this.name, this.launchDate) {
  }

  Spacecraft.unlaunched(String name) : this(name, null);

  int? get launchYear => launchDate?.year; // read-only non-final property

  String describe() {
    var description = 'I am a Spacecraft called: $name';
    print(description);
    var launchDate = this.launchDate; // Type promotion doesn't work on getters.
    if (launchDate != null) {
      int years = DateTime
          .now()
          .difference(launchDate)
          .inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
    return description;
  }

  int returnToEarth(int mins) {
    print(" I will return to earth in $mins mins");
    return 0;
  }
}
```

```dart
//Start remote server for Spacecraft

import 'package:robotremoteserver_dart/robotremoteserver_dart.dart';

void main() async {
  final rrs = RobotRemoteServer(Spacecraft("voyager", DateTime(1977, 9, 5)));
  rrs.serve();
}
```

Define Robot Framework testsuite for Spacecraft

```robotframework
*** Settings ***
Library           Remote    http://${ADDRESS}:${PORT}    WITH NAME    Spacecraft

*** Variables ***
${ADDRESS}        127.0.0.1
${PORT}           8270

*** Test Cases ***
Describe spacecraft
    ${spacecraft details} =    Spacecraft.describe
    Log    ${spacecraft details}

Return to earth
    Spacecraft.Return To Earth    10

```

## Run Robot Framework testcase

Install [robot framework](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst) first

run the testcase 

robot .

### dart pub package
https://pub.dev/packages/robotremoteserver_dart
