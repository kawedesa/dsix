import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
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
          initialData: Game.newGame(0, 0),
          create: (context) => database
              .collection('game')
              .doc('gameID')
              .snapshots()
              .map((game) => Game.fromMap(game.data())),
        ),

        //PLAYERS
        StreamProvider<List<Player>>(
            initialData: const [],
            create: (context) => database
                .collection('game')
                .doc('gameID')
                .collection('players')
                .snapshots()
                .map((querySnapshot) => querySnapshot.docs
                    .map((player) => Player.fromMap(player.data()))
                    .toList())),

        //SPAWNERS
        StreamProvider<List<Spawner>>(
            initialData: const [],
            create: (context) => database
                .collection('game')
                .doc('gameID')
                .collection('spawners')
                .snapshots()
                .map((querySnapshot) => querySnapshot.docs
                    .map((spawner) => Spawner.fromMap(spawner.data()))
                    .toList())),

        //NPCS
        StreamProvider<List<Npc>>(
            initialData: const [],
            create: (context) => database
                .collection('game')
                .doc('gameID')
                .collection('npcs')
                .snapshots()
                .map((querySnapshot) => querySnapshot.docs
                    .map((npc) => Npc.fromMap(npc.data()))
                    .toList())),
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
