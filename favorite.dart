import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contactprovider.dart';
import 'theme.dart';

// ignore: must_be_immutable
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'basket ',
            style: TextStyle(color: secendery, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: secendery,
          ),
        ),
      ),
      body: Column(
        children: [
        
          Divider(color: Colors.grey),
          SizedBox(height: 10),

          
          Expanded(
            child: ListView.builder(
              itemCount: allcontact.length,
              itemBuilder: (context, index) {
                var person = allcontact[index];
                return Column(
                  children: [
                    if (person.isFavorite)
                      ListTile(
                        title: Text(
                          person.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: primaryColor,
                          ),
                        ),
                        subtitle: Text(person.numb['phone'].toString()),
                        leading: Icon(
                          Icons.book_rounded,
                          color: primaryColor,
                        ),
                        trailing: Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                        ),
                      ),
                    if (person.isFavorite) const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget buildContactAvatar(String imagePath, String name) {
    return Column(
      children: [
        Stack(
          children: [
            ClipOval(
              child: Image.asset(
                imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 85, 50, 109),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
