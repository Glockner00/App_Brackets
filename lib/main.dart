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
              child: Text('Groups'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BracketScreen()),
                );
              },
              child: Text('Group Stage'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FinalStagePage()),
                );
              },
              child: Text('Final Stage'),
            ),
          ],
        ),
      ),
    );
  }
}

class FinalStagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Stage Brackets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Horizontal scroll
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Vertical scroll
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Generate the columns dynamically with adjustable parameters
                  createBracketColumn(
                      numPairs: 16,
                      columnIndex: 0,
                      pairSpacing: 40,
                      startVerticalOffset: 0),
                  SizedBox(width: 150.0), // Space between columns
                  createBracketColumn(
                      numPairs: 8,
                      columnIndex: 1,
                      pairSpacing: 120,
                      startVerticalOffset: 40),
                  SizedBox(width: 150.0),
                  createBracketColumn(
                      numPairs: 4,
                      columnIndex: 2,
                      pairSpacing: 280,
                      startVerticalOffset: 120),
                  SizedBox(width: 150.0),
                  createBracketColumn(
                      numPairs: 2,
                      columnIndex: 3,
                      pairSpacing: 600,
                      startVerticalOffset: 280),
                  SizedBox(width: 150.0),
                  createBracketColumn(
                      numPairs: 1,
                      columnIndex: 4,
                      pairSpacing: 0,
                      startVerticalOffset: 600),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to create a bracket column with customizable spacing and vertical offset
  Widget createBracketColumn({
    required int numPairs,
    required int columnIndex,
    required double pairSpacing,
    required double
        startVerticalOffset, // New parameter to adjust where the column starts vertically
  }) {
    return Padding(
      padding: EdgeInsets.only(
          top: startVerticalOffset), // Adjust the column's vertical position
      child: Column(
        children: List<Widget>.generate(numPairs, (int index) {
          return Column(
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 0), // Space between player boxes
              SizedBox(
                width: 150,
                height: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: pairSpacing), // Space between pairs, adjustable
            ],
          );
        }),
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
