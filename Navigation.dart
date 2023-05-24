
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'product.dart';
import 'product_repository.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigation extends StatefulWidget {
    BottomNavigation({Key? key}) : super(key: key);

   @override
   State<BottomNavigation> createState() => _BottomNavigationState();


   final List<String> imgList = [
     "Images/slid1.jpg",
     "Images/slid2.jpg",
     "Images/slid3.jpg",
     "Images/slid4.jpg",
   ];

 }

class CardItems {
  final String assetImage;
  final String tittle;
  final  String subtitle;

  const CardItems({
    required this.assetImage,
    required this.subtitle,
    required this.tittle,
  });
}


List<Container> _buildGridCards(BuildContext context){
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if (products.isEmpty) {
    return const <Container>[];
  }

 final ThemeData theme = Theme.of(context);
  final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

  return products.map((product) {
    return Container(
      width: 500,
      height: 500,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black26,
        semanticContainer: true,
        elevation: 7.0,

        clipBehavior: Clip.antiAliasWithSaveLayer,

        // TODO: Adjust card heights (103)
        child: Column(
        // TODO: Center items on the card (103)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        AspectRatio(
        aspectRatio: 19 / 9,
        child: Image.asset(
        product.assetName,
        package: product.assetPackage,
        // TODO: Adjust the box size (102)
    ),
    ),
    Expanded(
    child: Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
    child: Column(
    // TODO: Align labels to the bottom and center (103)
    crossAxisAlignment: CrossAxisAlignment.start,
    // TODO: Change innermost Column (103)
    children: <Widget>[
    // TODO: Handle overflowing labels (103)
    Text(
    product.name,
    style: theme.textTheme.titleLarge,
    maxLines: 1,
    ),
    //const SizedBox(height: 4.0),
    Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(

    height: 21,
    width: 50,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.blue,
    ),
    child:Text(
    formatter.format(product.price),
    style: TextStyle(
    color: Colors.white,

    ),

    ),
    ),

    IconButton(onPressed: (){

    }, icon: Icon(Icons.favorite_border_outlined,size: 25,color: Colors.red,))
    ],
    )

    ],
    ),
    ),
    ),
    ],
    ),
      )
    );
  }).toList();
}









 class _BottomNavigationState extends State<BottomNavigation> {

   int _currentTabIndex = 0;
   Color _favIconColor = Colors.white;
   late TextEditingController controller;

   int _current = 0;
   void _changeColor() {
     setState(() {
       _favIconColor = (_favIconColor == Colors.white)
           ? Colors.red
           : Colors.white;


     });
   }

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     controller = TextEditingController();
   }

   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();

     List<CardItems> items = [
     const   CardItems(
           assetImage: "Images/lv.png", subtitle: "1", tittle: "Louis vuitton"),
     const    CardItems(
           assetImage: "Images/LB.png", subtitle: "2", tittle: "Louboutin"),
       const  CardItems(
           assetImage: "Images/l.jpg", subtitle: "3", tittle: "Louis"),
       const CardItems(
           assetImage: "Images/V.jpg", subtitle: "4", tittle: " vuitton")
     ];
     List<Card> _buildGridCards(int count) {
       List<Card> cards = List.generate(
         count,
             (int index) {
           return Card(
             clipBehavior: Clip.antiAlias,
             child: Column(
               children: <Widget>[
                 AspectRatio(aspectRatio: 18.0 / 11.0,
                   child: Image.asset("Images/LB.jpg"),
                 ),
                 Padding(padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                   child: const Column(
                     children: const <Widget>[
                       Text('title'),
                       SizedBox(height: 8.0,),
                       Text("Secondary Text"),
                     ],
                   ),
                 )
               ],
             ),
           );
         },
       );
       return cards;
     }
   }
     Widget build(BuildContext context) {
       double width = MediaQuery
           .of(context)
           .size
           .width;
       final List<Widget> imageSliders = widget.imgList.map((item) =>
           Container(

             child: ClipRRect(
               borderRadius: BorderRadius.all(Radius.circular(25)),
               child: Stack(
                 children: [
                   Image.asset(
                     item, fit: BoxFit.cover, height: 130, width: 300,),
                   Positioned(
                       top: 0.0,
                       bottom: 0.0,
                       left: 0.0,
                       right: 10,

                       child: Container(

                         height: 130,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(25),


                         ),
                       )
                   )
                 ],
               ),
             ),
           )).toList();
       final _KTabPages = <Widget>[
         SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Column(
                 children: [
                   Stack(
                     children: [
                       Padding(
                         padding: EdgeInsets.only(top: 15,),
                         child: CarouselSlider(
                           items: imageSliders,
                           options: CarouselOptions(autoPlay: true,
                               padEnds: true,
                               enlargeCenterPage: true,
                               enableInfiniteScroll: false,
                               height: 130,
                               viewportFraction: 1,
                               aspectRatio: 16 / 9,
                               onPageChanged: (index, reason) {
                                 setState(() {
                                   _current = index;
                                 });
                               }
                           ),
                         ),
                       ),
                       Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           mainAxisSize: MainAxisSize.max,
                           children: widget.imgList.map((path) {
                             int index = widget.imgList.indexOf(path);
                             return Container(
                               width: 8,
                               height: 8,
                               alignment: Alignment.bottomCenter,
                               margin: const EdgeInsets.only(top: 120,),
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: _current == index
                                       ? const  Color.fromRGBO(0, 0, 0, 0.9)
                                       : const Color.fromRGBO(0, 0, 0, 0.4)
                               ),

                             );
                           }).toList()
                       ),
                     ],
                   ),
                   sectionTitle("Categories"),
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     controller: ScrollController(
                       initialScrollOffset: 0.5,
                     ),
                     child: Container(
                       child: Row(
                         children: [
                           allFriends(width / 4),
                         ],
                       ),
                     ),
                   ),
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Column(
                       children: [
                          Row(
                            children: [
                              BuildCard(items: CardItems(assetImage: "Images/lv.png", subtitle:"\$1200", tittle: "louis vuitton shoes")),
                              SizedBox(width: 12,),
                              BuildCard(items: CardItems(assetImage: "Images/L.jpg", subtitle:"\$70", tittle: "louis vuiton bag")),
                              SizedBox(width: 12,),
                              BuildCard(items: CardItems(assetImage: "Images/LB.png", subtitle:"\$450", tittle: "Louboutin")),
                              SizedBox(width: 12,),
                              BuildCard(items: CardItems(assetImage: "Images/V.jpg", subtitle:" \$900", tittle: "Louis vuiton")),
                              Container(
                                  child:Flexible(
                                    child:GridView.count(
                                        crossAxisCount: 2,
                                        padding: const EdgeInsets.all(16.0),
                                        shrinkWrap: true,
                                        childAspectRatio: 8.0 / 9.0,
                                        children: _buildGridCards(context)
                                    ),
                                  )

                              )

                            ],
                          ),
                       ],
                     ),
                   ),
                  ]

       )

             ),
         const Center(child: Icon(
             Icons.confirmation_num_sharp, size: 64.0, color: Colors.teal)),
         const Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
         const Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
       ];
       final _KBottomNavigationBarItems = <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.home,), label: "Home",
         ),

         BottomNavigationBarItem(icon: IconButton(
             onPressed: () {
               Navigator.push(context, _NextPage("My Cart"));
             },
             icon: const Icon(Icons.shopping_cart)),
             label: "My Cart"
         ),
         BottomNavigationBarItem(icon: IconButton(
           onPressed: () {
             Navigator.push(context, _NextPage("WhishList"));
           },
           icon: const Icon(Icons.favorite,),
         ),
           label: "Whishlist",
         ),


         const BottomNavigationBarItem(
             icon: Icon(Icons.person,), label: "Account"),

       ];
       assert(_KTabPages.length == _KBottomNavigationBarItems.length);
       final BottomNavBar = BottomNavigationBar(
         items: _KBottomNavigationBarItems,
         currentIndex: _currentTabIndex,
         type: BottomNavigationBarType.fixed,
         onTap: (int index) {
           setState(() {
             _currentTabIndex = index;
           });
         },
       );
       return Scaffold(
         appBar: AppBar(

             toolbarHeight: 70,
             //backgroundColor: Colors.white,

             actions: [
               const Text(
                 "DeBrandShopp",
                 style: TextStyle(
                   fontSize: 18,
                   color: Colors.blue,
                   fontFamily: "Billabong",
                   fontWeight: FontWeight.bold,
                 ),
               ),
               Container(

                   margin: const EdgeInsets.all(7),
                   width: 200.0,
                   height: 30,
                   //color: Colors.black.withOpacity(0.07),
                   child: TextField(
                     controller: controller,
                     cursorColor: Colors.blue,
                     cursorHeight: 30,
                     style: const TextStyle(
                       fontSize: 15,
                       height: 2,
                       // color: Colors.blue

                     ),

                     decoration: InputDecoration(
                       // filled: true,
                       //focusColor: Colors.black.withOpacity(1),
                         focusedBorder: OutlineInputBorder(
                           borderSide: const BorderSide(
                               color: Colors.blue, width: 2.0),
                           borderRadius: BorderRadius.circular(20),
                         ),
                         isDense: true,
                         hintText: "Rechercher...",


                         hintStyle: const TextStyle(
                             fontSize: 13,
                             height: 1.5
                         ),
                         fillColor: Colors.black.withOpacity(0.05),
                         filled: true,
                         suffixIcon: const Icon(Icons.search_rounded),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),

                         )

                     ),

                   )
               ),
               CircleAvatar(
                 backgroundColor: Colors.black.withOpacity(0.1),
                 child: IconButton(
                   onPressed: () {},
                   icon: const Icon(Icons.notifications,),
                 ),
               )
             ]
         ),


         body: _KTabPages[_currentTabIndex],
         bottomNavigationBar: BottomNavBar,

         /*  GridView.count(
           crossAxisCount: 2,
           padding: const EdgeInsets.all(16.0),
           childAspectRatio: 8.0 / 9.0,
           children: _buildGridCards(context) // Changed code
       ),*/

       );

     }
   }

 class _NextPage extends MaterialPageRoute<void> {
   _NextPage(String text)
       :super(
       builder: (BuildContext context) {
         return Scaffold(
             appBar: AppBar(
               backgroundColor: Colors.blue,
               foregroundColor: Colors.white,
               title:  Text("$text"),
               elevation: 2.0,
              centerTitle: true,
             ),
             body: Builder(
                 builder: (BuildContext context) =>
                     Container(
                       child: Column(
                         children: [
                           const Text("delaure"),

                         ],
                       ),
                     )
             )
         );
       }
   );
 }
Column Trendingimage( String imagepath,double width){
  return Column(
    children: [
      Container(
        margin:const EdgeInsets.only(right: 15,left: 10),

        width: width,
        height: width,
       // color: Colors.white,
        decoration: BoxDecoration(
         // border: Border.all(color: Colors.blue),
          image: DecorationImage(image: AssetImage(imagepath),fit:BoxFit.cover),
        //  borderRadius: BorderRadius.circular(10),
          color: Colors.white,


          boxShadow: const [BoxShadow(color: Colors.black45)],
        ),
      ),

    ],
  );
}

Card Trending(double width )

{
  Map<String, String> friends = {


    "1":"Images/L.jpg",
    "2":"Images/LB.png",
    "3":"Images/lv.jpg",
    "4":"Images/V.jpg",



  };
  List<Widget> children =[];
  friends.forEach((name, imagepath) {
    children.add( Trendingimage( imagepath, width));
  });
  return Card(
  child:
      Row(
        children:
          children,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
      )

  );
}
/*Widget buildCard() => Container(
child:GridView.count(crossAxisCount: 2,
  crossAxisSpacing: 10.0,
  primary:false,
  padding: EdgeInsets.all(15.0),
  children: List<Widget>.generate(
    16,
      (index){
      return GridTile(child: Card(
        color: Colors.black45.withOpacity(1.0),
        //Color((Ramdom().nextDouble()*0xFFFFFF).toInt()<<0)

        elevation: 7.0,
        shadowColor: Colors.black45,
      ),
      );
      }
),
)
);*/

Widget BuildCard ({required  items, }) => Container(
  width: 200,
  height: 300,

  decoration:  BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 3,
        blurStyle: BlurStyle.inner,
        offset: Offset.zero,

      )
    ]
    ),

  child:Column(
    children: [

      Expanded(child:AspectRatio(aspectRatio: 4/3,
        child:
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:Image.asset(items.assetImage,fit: BoxFit.cover,),
        )
  ),
),
       // const  SizedBox(height: 4,),
        Text(
          items.tittle,
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),

        ),
      Text(
        items.subtitle,
        style:const  TextStyle(fontSize: 18,),

      ),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    IconButton(
      splashRadius: 1,
      splashColor: Colors.red,
      iconSize: 30,
      onPressed:(){},
      tooltip: 'Change_Color',
      //padding: EdgeInsets.only(left: 140),
      icon: Icon(Icons.favorite_border_outlined,),
    ),



    IconButton(onPressed: (){}, icon: const Icon(Icons.add_shopping_cart)),


  ],
)


    ],
  )
  );
Widget sectionTitle(String text) {
  return Padding(
      padding: const EdgeInsets.only(top: 7, right: 190),

      child: Text(
        text,

        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 18,
        ),
      )
  );
}
   Column actorsImage(String imagepath, double width) {
   return Column(
   children: [
   Container(
   margin: const EdgeInsets.only(right: 15, left: 10),

   width: width,
   height: width,
   //color: Colors.white,
   decoration: BoxDecoration(
   border: Border.all(color: Colors.blue),
   image: DecorationImage(
   image: AssetImage(imagepath), fit: BoxFit.cover),
   borderRadius: BorderRadius.circular(10),
   color: Colors.white,


   boxShadow: const [BoxShadow(color: Colors.black45)],
   ),
   ),

   ],
   );
   }


   Row allFriends(double width) {
   Map<String, String> friends = {


   "1": "Images/act11.png",
   "2": "Images/act22.png",
   "3": "Images/act33.jpg",
   "4": "Images/act44.png",
   "5": "Images/act55.jpg",
   "6": "Images/act66.png",
   "7": "Images/act77.png",
   "8": "Images/act88.png",
   "9": "Images/act99.jpg",


   };
   List<Widget> children = [];
   friends.forEach((name, imagepath) {
   children.add(actorsImage(imagepath, width));
   });
   return Row(
   children: children,
   mainAxisSize: MainAxisSize.max,
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   );
   }
