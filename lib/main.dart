import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = '🤠';
  Color _backgroundColor = Colors.yellow;

  final Map<String, int> _counts = {
    'happy': 0,
    'sad': 0,
    'excited': 0,
  };

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get counts => _counts;

  void setHappy() {
    _currentMood = '🤠';
    _backgroundColor = Colors.yellow;
    _counts['happy'] = (_counts['happy'] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = '🥺';
    _backgroundColor = Colors.blue;
    _counts['sad'] = (_counts['sad'] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = '💥';
    _backgroundColor = Colors.orange;
    _counts['excited'] = (_counts['excited'] ?? 0) + 1;
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bg = context.watch<MoodModel>().backgroundColor;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(title: Text('Mood Toggle Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How are you feeling?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            MoodDisplay(),
            SizedBox(height: 50),
            MoodButtons(),
            MoodCounter(),
          ],
        ),
      ),
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Text(moodModel.currentMood, style: TextStyle(fontSize: 100));
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('🤠'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('🥺'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('💥'),
        ),
      ],
    );
  }
}
class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, model, child) {
        final c = model.counts;
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Happy: ${c['happy'] ?? 0}   •   Sad: ${c['sad'] ?? 0}   •   Excited: ${c['excited'] ?? 0}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}