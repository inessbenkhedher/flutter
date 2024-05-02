import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'footer.dart';

class Mulesage extends StatelessWidget {
  const Mulesage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Mules"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: instagramPosts.length + 1,
      itemBuilder: (context, index) {
        if (index == instagramPosts.length) {
          return BottomFooter();
        } else {
          final post = instagramPosts[index];
          return InstagramPost(
            postAsset: post.postAsset,
            productName: post.productName,
            price: post.price,
          );
        }
      },
    );
  }
}

class InstagramPost extends StatelessWidget {
  final String postAsset;
  final String productName;
  final String price;

  InstagramPost({
    required this.postAsset,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              productName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 200, // Adjust the height as needed
            child: Image.asset(
              postAsset,
              fit: BoxFit.cover, // Ensure the image covers the container completely
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '\$$price',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle add to cart action
              print('Add to cart');
            },
            child: Text('Ajouter au panier'),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class InstagramPostData {
  final String postAsset;
  final String productName;
  final String price;

  InstagramPostData({
    required this.postAsset,
    required this.productName,
    required this.price,
  });
}

final List<InstagramPostData> instagramPosts = [
  InstagramPostData(
    postAsset: "assets/images/mu1.jpg", // Ajoutez l'URL de l'image
    productName: "Produit 1",
    price: "10", // Prix du produit
  ),
  InstagramPostData(
    postAsset: "assets/images/mu2.jpg", // Ajoutez l'URL de l'image
    productName: "Produit 2",
    price: "20", // Prix du produit
  ),
  InstagramPostData(
    postAsset: "assets/images/mu3.jpg", // Ajoutez l'URL de l'image
    productName: "Produit 2",
    price: "20", // Prix du produit
  ),
  InstagramPostData(
    postAsset: "assets/images/mu4.jpg", // Ajoutez l'URL de l'image
    productName: "Produit 2",
    price: "20", // Prix du produit
  ), InstagramPostData(
    postAsset: "assets/images/mu5.jpg", // Ajoutez l'URL de l'image
    productName: "Produit 2",
    price: "20", // Prix du produit
  ),InstagramPostData(
    postAsset: "assets/images/mu6.jpg", // Ajoutez l'URL de l'image
    productName: "Produit 2",
    price: "20", // Prix du produit
  ),


  // Ajoutez d'autres produits ici
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Beginner Insta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Mulesage(),
    );
  }
}
