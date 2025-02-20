import 'package:demo/services/api_service.dart';
import 'package:demo/services/shared_service.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? finalEmail = "";
  String userProfileData = "";
  List<String> categoryList = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2E7D32),
                  Color(0xFF388E3C),
                  Color(0xFF66BB6A),
                ],
                begin: Alignment.topRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, \n Good Morning',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Explore Categories',
                  style: TextStyle(
                      color: Color.fromARGB(255, 7, 78, 10),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          Flexible(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 24,
              ),
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: categoryList[index]);
              },
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          GestureDetector(
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 6, 131, 15),
              ),
              child: const Center(
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              SharedService.logout(context);
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(category, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
