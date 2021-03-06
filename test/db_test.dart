import 'package:flutter_atm/app/repository/local/database.dart';
import 'package:test/test.dart';

void main() {
  late MyDatabase database;

  setUp(() {
    database = MyDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  // —————————————————————————————————————————————————————————————————————————
  // START HERE
  // —————————————————————————————————————————————————————————————————————————
  test('.parse() fails on invalid input', () {
    setUp((){});
    expect(() => int.parse('X'), throwsFormatException);
  });


  test('users can be created & make sure valid is Exists', () async {
    const userNameInput = 'aditP001';
    // step 1 : input data
    final entry = UsersCompanion.insert(
      username: userNameInput, // pk
      balance: 0,
      createAt: DateTime.now(),
    );
    await database.createUser(entry);

    // step 2 : search data
    var currentUsername = '';
    database.getUserByUsername(userNameInput).listen((event) {
      currentUsername = event.username;
    });
    // step 3 : expect (create <> search)
    expect(entry.username, currentUsername);
  });
}
