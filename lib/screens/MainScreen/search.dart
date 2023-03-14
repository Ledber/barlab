import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<test> {
  late final CollectionReference _collectionRef;

  @override
  void initState() {
    super.initState();
    _collectionRef = FirebaseFirestore.instance.collection('coctailes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Обновляем виджет при изменении текста
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _collectionRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final query =
                      (ModalRoute.of(context)?.settings.arguments as String?) ??
                          '';
                  final lowercaseQuery =
                      query.toLowerCase(); // Переводим запрос в нижний регистр

                  final filteredDocs = snapshot.data!.docs.where((doc) {
                    final name = (doc['name'] as String?)?.toLowerCase() ?? '';
                    return name.contains(
                        lowercaseQuery); // Сравниваем в нижнем регистре
                  });

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final doc = filteredDocs.elementAt(index);
                      return ListTile(
                        title: Text(doc['name'] as String? ?? ''),
                        subtitle: Text(doc['glass'] as String? ?? ''),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchDelegateExample extends SearchDelegate<String> {
  final CollectionReference _collectionRef;

  SearchDelegateExample(CollectionReference collectionRef)
      : _collectionRef = collectionRef,
        super(searchFieldLabel: 'Search...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Кнопка "назад" в AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Не используется, результаты выводятся в SearchPage
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _collectionRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final lowercaseQuery = query.toLowerCase(); // Переводим запрос в нижни
        final List<DocumentSnapshot> searchResults =
            snapshot.data!.docs.where((doc) {
          final name = doc['name']
              .toString()
              .toLowerCase(); // Получаем значение поля 'name' и переводим в нижний регистр
          return name.contains(
              lowercaseQuery); // Сравниваем со значением запроса в нижнем регистре
        }).toList();

        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final doc = searchResults[index];
            return ListTile(
              title: Text(doc['name']),
              subtitle: Text(doc['glass']),
              onTap: () {
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
