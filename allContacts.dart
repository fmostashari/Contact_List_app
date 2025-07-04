import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addNewContact.dart';
import 'contactprovider.dart';
import 'details.dart';
import 'theme.dart';

class AllContacts extends StatelessWidget {
  const AllContacts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;
    var dark = context.watch<ThemeProvider>().dark;
    Color textColor = dark ? secendery : gray;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'your books',
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
            )),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'your list',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secendery),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewContact(null)));
                    },
                    icon: Icon(
                      Icons.add,
                      color: secendery,
                    ))
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
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
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
                          color: Color.fromARGB(255, 214, 136, 136)),
                      secondaryBackground: Container(
                          color: const Color.fromARGB(255, 136, 216, 139)),
                      onDismissed: (direction) {
                        context
                            .watch<ContactProvider>()
                            .removeFromList(allcontact[index]);
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            person.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: textColor),
                          ),
                          subtitle: Text(
                            person.numb['phone'].toString(),
                            style: TextStyle(color: textColor),
                          ),
                          leading: Icon(
                            Icons.book,
                            color: primaryColor,
                          ),
                          trailing: IconButton(
                            icon: person.isFavorite
                                ? Icon(
                                    Icons.shopping_cart,
                                    color: primaryColor,
                                  )
                                : Icon(
                                    Icons.shopping_cart_outlined,
                                    color: primaryColor,
                                  ),
                            onPressed: () {
                              context.read<ContactProvider>().toggleFavorite(person);
                            },
                          ),
                        ),
                      ),
                    ),
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
