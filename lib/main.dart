import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/cubit/backboard_manager.dart';
import 'package:vampire_survivors_game/src/cubit/damage_effect_manager.dart';
import 'package:vampire_survivors_game/src/cubit/enemy_manager.dart';
import 'package:vampire_survivors_game/src/cubit/field_item_manager.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/cubit/key_event_manager.dart';
import 'package:vampire_survivors_game/src/cubit/levelup_item_manager.dart';
import 'package:vampire_survivors_game/src/cubit/missile_manager.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';
import 'package:vampire_survivors_game/src/cubit/timer_manager.dart';
import 'package:vampire_survivors_game/src/game_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GameManager()),
          BlocProvider(create: (context) => PlayerManager()),
          BlocProvider(create: (context) => BackboardManager()),
          BlocProvider(create: (context) => LevelUpItemManager()),
          BlocProvider(create: (context) => KeyEventManagerCubit()),
          BlocProvider(create: (context) => EnemyManager()),
          BlocProvider(create: (context) => MissileManager()),
          BlocProvider(create: (context) => DamageEffectManager()),
          BlocProvider(create: (context) => FieldItemManager()),
          BlocProvider(create: (context) => TimerManater()),
        ],
        child: const GameBoard(),
      ),
    );
  }
}
