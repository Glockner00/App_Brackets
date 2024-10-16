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

// HomeScreen with button to navigate to the GroupScreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart Tournament Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GroupScreen()),
            );
          },
          child: Text('View Groups'),
        ),
      ),
    );
  }
}

// GroupScreen to display 16 groups, each with 4 players
class GroupScreen extends StatelessWidget {
  // Preset of 64 players divided into 16 groups
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
