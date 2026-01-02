import 'package:flutter/material.dart';
import '../logic/game_engine.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int players = 4;
  late GameEngine engine;
  int askValue = 14;

  @override
  void initState() {
    super.initState();
    engine = GameEngine(players);
  }

  void restart() {
    setState(() {
      engine = GameEngine(players);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('கரணம் கார்டு விளையாட்டு')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Team A : ${engine.teamAPoints} | Team B : ${engine.teamBPoints}',
            style: const TextStyle(fontSize: 18),
          ),
          const Divider(),

          DropdownButton<int>(
            value: players,
            items: const [
              DropdownMenuItem(value: 4, child: Text('4 பேர்')),
              DropdownMenuItem(value: 6, child: Text('6 பேர்')),
              DropdownMenuItem(value: 8, child: Text('8 பேர்')),
            ],
            onChanged: (v) {
              if (v != null) {
                setState(() {
                  players = v;
                  engine = GameEngine(players);
                });
              }
            },
          ),

          Expanded(
            child: ListView.builder(
              itemCount: engine.hands.length,
              itemBuilder: (_, i) {
                return Card(
                  child: ListTile(
                    title: Text('Player ${i + 1}'),
                    subtitle: Wrap(
                      children: engine.hands[i]
                          .map(
                            (c) => Text(
                              '${c.colorName}${c.name} ',
                              style: const TextStyle(fontSize: 18),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Value கேட்க'),
                    onChanged: (v) {
                      askValue = int.tryParse(v) ?? askValue;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      engine.messaSuccess(askValue);
                    });
                  },
                  child: const Text('Success'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      engine.messaFail(askValue);
                    });
                  },
                  child: const Text('Fail'),
                ),
              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                engine.illegalPlay();
              });
            },
            child: const Text('Illegal Play'),
          ),

          if (engine.isGameOver())
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                engine.teamAPoints >= 15
                    ? '🏆 Team A வெற்றி | Team B – குணுக்கு'
                    : '🏆 Team B வெற்றி | Team A – குணுக்கு',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          TextButton(
            onPressed: restart,
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
