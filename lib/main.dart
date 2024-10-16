import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Tournament',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

// HomeScreen with buttons to navigate to GroupScreen or BracketScreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart Tournament Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupScreen()),
                );
              },
              child: Text('View Groups'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BracketScreen()),
                );
              },
              child: Text('View Brackets'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinalStageScreen()),
                );
              },
              child: Text('View Final Stage'),
            ),
          ],
        ),
      ),
    );
  }
}

class FinalStageScreen extends StatelessWidget {
  final List<String> players =
      List.generate(32, (index) => 'Player ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Stage Brackets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Round 1',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              FinalBracketWidget(
                  players: players.sublist(0, 16), nextRoundSlot: 5),
              SizedBox(height: 20),
              Text(
                'Semifinals',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              FinalBracketWidget(
                  players: players.sublist(16, 24), nextRoundSlot: 7),
              SizedBox(height: 20),
              Text(
                'Final',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              FinalBracketWidget(
                  players: players.sublist(24, 32), nextRoundSlot: 1),
            ],
          ),
        ),
      ),
    );
  }
}

// GroupScreen to display 16 groups, each with 4 players
class GroupScreen extends StatelessWidget {
  final List<List<String>> groups = List.generate(16, (groupIndex) {
    return List.generate(4, (playerIndex) {
      return 'Player ${(groupIndex * 4) + playerIndex + 1}';
    });
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Groups'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return GroupWidget(
              group: groups[index],
              groupNumber: index + 1,
            );
          },
        ),
      ),
    );
  }
}

// Widget to display each group with its players
class GroupWidget extends StatelessWidget {
  final List<String> group;
  final int groupNumber;

  GroupWidget({required this.group, required this.groupNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Group $groupNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            for (var player in group)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(player, style: TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}

// BracketScreen to display tournament brackets for all groups
class BracketScreen extends StatelessWidget {
  // Mocked groups and players
  final List<List<String>> groups = List.generate(16, (groupIndex) {
    return List.generate(4, (playerIndex) {
      return 'Player ${(groupIndex * 4) + playerIndex + 1}';
    });
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Brackets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return GroupBracketWidget(
              group: groups[index],
              groupNumber: index + 1,
            );
          },
        ),
      ),
    );
  }
}

// Widget to display the bracket for each group
class GroupBracketWidget extends StatelessWidget {
  final List<String> group;
  final int groupNumber;

  GroupBracketWidget({required this.group, required this.groupNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Group $groupNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Round 1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            MatchWidget(player1: group[0], player2: group[1]),
            MatchWidget(player1: group[2], player2: group[3]),
            SizedBox(height: 10),
            Text(
              'Round 2',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            MatchWidget(player1: group[0], player2: group[2]),
            MatchWidget(player1: group[1], player2: group[3]),
          ],
        ),
      ),
    );
  }
}

// Widget to display individual matches
class MatchWidget extends StatelessWidget {
  final String player1;
  final String player2;

  MatchWidget({required this.player1, required this.player2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(player1, style: TextStyle(fontSize: 16)),
          Text('vs', style: TextStyle(fontSize: 16)),
          Text(player2, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
