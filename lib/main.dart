import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/view/home/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final database = FirebaseFirestore.instance;
    final User user = User();

    return MultiProvider(
      providers: [
        //USER
        Provider(create: (context) => user),

        //GAME
        StreamProvider<Game>(
          initialData: Game.newGame(),
          create: (context) => database
              .collection('game')
              .doc('gameID')
              .snapshots()
              .map((game) => Game.fromMap(game.data())),
        ),
      ],
      child: MaterialApp(
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return const HomeView();
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
