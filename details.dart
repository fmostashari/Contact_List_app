import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addNewContact.dart';
import 'contactprovider.dart';
import 'theme.dart';
import 'utils.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  int id;
  Details(this.id, {super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'Details',
            style: TextStyle(color: secendery, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: secendery,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(125),
              child: Container(
                height: 200,
                width: 200,
                padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryColor,
          image: DecorationImage(
            image: AssetImage("image/person.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
              )
            ),
            Text(
              allcontact[widget.id].name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text('price'),
                subtitle: Text(allcontact[widget.id].numb['phone'].toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  
                    
                  SizedBox(height: 10),
                  
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    allcontact[widget.id].isFavorite
                        ? context.read<ContactProvider>().removeFromFavorite(allcontact[widget.id])
                        : context.read<ContactProvider>().addToFavorite(allcontact[widget.id]);
                  },
                  icon: allcontact[widget.id].isFavorite
                      ? Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                        )
                      : Icon(
                          Icons.shopping_cart_outlined,
                          color: primaryColor,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewContact(allcontact[widget.id].id!),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
