import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/dashboard/category/category_detail_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController searchController = TextEditingController();

  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * .16),
                  const Text(
                    'Virtual Chamber',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: searchController,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                            hintText: 'Search for lawyers',
                            border: InputBorder.none,
                            prefixIcon: (searchText.isEmpty)
                                ? const Icon(Icons.search)
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      searchText = '';
                                      searchController.clear();
                                      setState(() {});
                                    },
                                  ),
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              // color: const Color(0xFF353535),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          }),
                    ),
                    // Image.asset(
                    //   'assets/filter.png',
                    //   height: 20,
                    //   width: 20,
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lawyers')
                      .orderBy('category')
                      .startAt([searchText.toUpperCase()]).endAt(
                          ['$searchText\uf8ff']).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 233),
                        child: CircularProgressIndicator(),
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 233),
                        child: Text(
                          'No lawyer Registered yet',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.amber.shade700),
                        ),
                      ));
                    } else {
                      Set<String> categories = Set<String>();
                      for (var doc in snapshot.data!.docs) {
                        var category = doc['category'];
                        if (category != null) {
                          categories.add(category);
                        }
                      }
                      return Expanded(
                        child: GridView.builder(
                          itemCount: categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var category = categories.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                Get.to(() =>
                                    CategoryDetailScreen(category: category));
                              },
                              child: Card(
                                elevation: 2,
                                child: Container(
                                  width: 154,
                                  height: 173,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black87,
                                      width: 0.1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      children: [
                                        8.heightBox,
                                        Image.asset(
                                          imagesData[index].imagePath,
                                          fit: BoxFit.cover,
                                          height: 121,
                                          width: 137,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          category,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageData {
  final String imagePath;

  ImageData(
    this.imagePath,
  );
}

List<ImageData> imagesData = [
  ImageData(
    'assets/civil.png',
  ),
  ImageData(
    'assets/criminal.png',
  ),
  ImageData(
    'assets/divorce.png',
  ),
  ImageData(
    'assets/family.png',
  ),
  ImageData(
    'assets/labor.png',
  ),

  ImageData(
    'assets/military.png',
  ),
  // Add more image data as needed
];
