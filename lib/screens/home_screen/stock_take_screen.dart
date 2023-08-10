import 'package:flutter/material.dart';


class formuuu extends StatelessWidget {
  const formuuu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Layout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Top TextField',
              ),
            ),
            SizedBox(height: 20),
            ...List.generate(6, (index) => _buildRow(context, index))
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text('Heading ${index + 1}: '),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'TextField ${index + 1}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
