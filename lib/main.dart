import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        'Algorithms to Live By transforms the wisdom of computer science into strategies for human living.', 'pdfUrl': 'https://example.com/algorithms.pdf'},
    {'title': 'Beginning Programming All-in-One Desk Reference for Dummies', 'author': 'Wallace Wang', 'description': 'Beginning Programming All In One Desk Reference For Dummies shows you how to decide what you want your program to do, '
        'turn your instructions into “machine language” that the computer understands, use programming best practices, '
        'explore the “how” and “why” of data structuring, and more. '
        'You’ll even get a look into various applications like database management, bioinformatics, computer security, and artificial intelligence. '
        'Soon you\'ll realize that — wow! You\'re a programmer!', 'pdfUrl': 'https://example.com/programming.pdf'},
    {'title': 'Streamlit for Data Science: Create interactive data apps in Python', 'author': 'Tyler Richards', 'description': 'If you work with data in Python and are looking to create data apps that showcase ML models and make beautiful interactive visualizations, then this is the ideal book for you. Streamlit for Data Science, Second Edition, shows you how to create and deploy data apps quickly, all within Python. This helps you create prototypes in hours instead of days!'
        'Written by a prolific Streamlit user and senior data scientist at Snowflake, this fully updated second edition builds on the practical nature of the previous edition with exciting updates, including connecting Streamlit to data warehouses like Snowflake, integrating Hugging Face and OpenAI models into your apps, and connecting and building apps on top of Streamlit databases. Plus, there is a totally updated code repository on GitHub to help you practice your newfound skills.', 'pdfUrl': 'https://example.com/streamlit.pdf'},
    {'title': 'Flutter for Beginners', 'author': 'Alessandro Biessek', 'description': 'Flutter is Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. This book is an introduction to Flutter for beginners.', 'pdfUrl': 'https://example.com/flutter.pdf'},
    {'title': 'Dart Programming Language', 'author': 'Kathy Walrath', 'description': 'Dart is a client-optimized language for fast apps on any platform. This book covers the Dart language in detail.', 'pdfUrl': 'https://example.com/dart.pdf'},
    {'title': 'Mobile App Development with Flutter', 'author': 'William J. Francis', 'description': 'Learn to build mobile apps with Flutter, Google\'s open-source framework for building beautiful, natively compiled applications.', 'pdfUrl': 'https://example.com/mobile.pdf'},
    {'title': 'Clean Code: A Handbook of Agile Software Craftsmanship', 'author': 'Robert C. Martin', 'description': 'Even bad code can function. But if code isn\'t clean, it can bring a development organization to its knees. Every year, countless hours and significant resources are lost because of poorly written code.', 'pdfUrl': 'https://example.com/clean_code.pdf'},
    {'title': 'The Pragmatic Programmer', 'author': 'Andrew Hunt', 'description': 'The Pragmatic Programmer is one of those rare tech books you\'ll read, re-read, and read again over the years.', 'pdfUrl': 'https://example.com/pragmatic.pdf'},
    {'title': 'Design Patterns: Elements of Reusable Object-Oriented Software', 'author': 'Gang of Four', 'description': 'Capturing a wealth of experience about the design of object-oriented software, four top-notch designers present a catalog of simple and succinct solutions to commonly occurring design problems.', 'pdfUrl': 'https://example.com/design_patterns.pdf'},
    {'title': 'Refactoring: Improving the Design of Existing Code', 'author': 'Martin Fowler', 'description': 'Refactoring is a controlled technique for improving the design of an existing code base. Its essence is applying a series of small behavior-preserving transformations, each of which "too small to be worth doing".', 'pdfUrl': 'https://example.com/refactoring.pdf'},
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
                    pdfUrl: books[index]['pdfUrl']!,
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
  final String pdfUrl;

  BookDetailScreen({required this.title, required this.author, required this.description, required this.pdfUrl});

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
                       pdfUrl: pdfUrl,
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

class ReadingBookFile extends StatefulWidget {
  final String pdfUrl;

  ReadingBookFile({required this.pdfUrl});

  @override
  _ReadingBookFileState createState() => _ReadingBookFileState();
}

class _ReadingBookFileState extends State<ReadingBookFile> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.pdfUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading Book')),
      body: WebViewWidget(controller: controller),
    );
  }
}