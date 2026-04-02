import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BookListScreen(),
  ));
}

class BookListScreen extends StatelessWidget {
  final List<Map<String, String>> books = [
    {'title': 'Algorithms to Live By: The Computer Science of Human Decisions', 'author': 'Brian Christian', 'description': 'In a dazzlingly interdisciplinary work, '
        'Brian Christian and Tom Griffiths show how algorithms developed for computers also untangle very human questions. '
        'They explain how to have better hunches and when to leave things to chance, how to deal with overwhelming choices and how best to connect with others. '
        'From finding a spouse to finding a parking spot, from organizing one’s inbox to peering into the future, '
        'Algorithms to Live By transforms the wisdom of computer science into strategies for human living.'},
    {'title': 'Beginning Programming All-in-One Desk Reference for Dummies', 'author': 'Wallace Wang', 'description': 'Beginning Programming All In One Desk Reference For Dummies shows you how to decide what you want your program to do, '
        'turn your instructions into “machine language” that the computer understands, use programming best practices, '
        'explore the “how” and “why” of data structuring, and more. '
        'You’ll even get a look into various applications like database management, bioinformatics, computer security, and artificial intelligence. '
        'Soon you’ll realize that — wow! You’re a programmer!'},
    {'title': 'Streamlit for Data Science: Create interactive data apps in Python', 'author': 'Tyler Richards', 'description': 'If you work with data in Python and are looking to create data apps that showcase ML models and make beautiful interactive visualizations, then this is the ideal book for you. Streamlit for Data Science, Second Edition, shows you how to create and deploy data apps quickly, all within Python. This helps you create prototypes in hours instead of days!'
        'Written by a prolific Streamlit user and senior data scientist at Snowflake, this fully updated second edition builds on the practical nature of the previous edition with exciting updates, including connecting Streamlit to data warehouses like Snowflake, integrating Hugging Face and OpenAI models into your apps, and connecting and building apps on top of Streamlit databases. Plus, there is a totally updated code repository on GitHub to help you practice your newfound skills.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book List')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index]['title']!),
            subtitle: Text(books[index]['author']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(
                    title: books[index]['title']!,
                    author: books[index]['author']!,
                    description: books[index]['description']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String description;

  BookDetailScreen({required this.title, required this.author, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: $title', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Author: $author', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            SizedBox(height: 12),
            Text('Description:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),

             ElevatedButton(
               onPressed: () {
                 Navigator.push(context,
                   MaterialPageRoute(
                     builder: (context) => ReadingBookFile(

                     ),
                   ),
                 );
               },
               child: Text('Read the book'),
             ),
          ],
        ),
      ),
    );
  }
}

class ReadingBookFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Text('Reading Book File');
    throw UnimplementedError();
  }
}