import 'package:contact_list_final/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'allContacts.dart';
import 'contactprovider.dart';
import 'details.dart';
import 'favorite.dart';
import 'setting.dart';
import 'theme.dart';

class Recents extends StatefulWidget {
  const Recents({
    super.key,
  });

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;
    var dark = context.watch<ThemeProvider>().dark;
    Color textColor = dark ? secendery : gray;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryColor,
          image: DecorationImage(
            image: AssetImage("image/patern2.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'book list',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secendery),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: secendery),
                  onSelected: (value) {
                    if (value == 'delete') {
                      setState(() {
                        context.read<ContactProvider>().removeAll();
                      });
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete All'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            SizedBox(
              height: 45,
              width: 380,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secendery,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allcontact.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var person = allcontact[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(index)));
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      background: Container(
                          color: const Color.fromARGB(255, 220, 127, 127)),
                      secondaryBackground: Container(
                          color: const Color.fromARGB(255, 141, 211, 167)),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          context
                              .read<ContactProvider>()
                              .removeFromList(allcontact[index]);
                        } else {
                          IconButton(
                           icon: Icon(Icons.shopping_cart),
                           onPressed: () {
                           Navigator.push(
                           context,
                            MaterialPageRoute(builder: (context) => FavoritePage()),
                            );
  },
);

                        }
                      },
                      child: Card(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  person.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: textColor),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                person.numb['phone'].toString(),
                                style: TextStyle(color: textColor),
                              ),
                              Text(
                                "ofogh press",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          leading: ClipOval(
                            child: Image.asset(
                              'image/person.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          trailing: Column(
                            children: [
                              SizedBox(height: 10),
                              Icon(
                                Icons.shopping_cart,
                                color: primaryColor,
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: secendery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoritePage()),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Setting()),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        color: primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllContacts()),
                        );
                      },
                      icon: Icon(
                        Icons.book,
                        color: primaryColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
