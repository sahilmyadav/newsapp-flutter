
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/categories_new_model.dart';
import '../view_models/news_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String category_name = 'general';
  List<String> categories_list = [
    "General",
    "Entertainment",
    "Health",
    "sport",
    "Business",
    "Technology"
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: categories_list.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        category_name = categories_list[index];
                        setState(() {
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right:5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: category_name == categories_list[index] ? Colors.blue :Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(child: Text(categories_list[index].toString(), style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white
                            ),)),
                          ),
                        ),
                      ),
                    );
                  },
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi(category_name),
                  builder: (BuildContext context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: SpinKitWanderingCubes(
                          size: 50,
                          color: Colors.black,
                        ),
                      );
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,

                          itemBuilder: (context, index){
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      height: height *.18,
                                      width: width * .3,
                                      placeholder: (context,url)=> Container(child: Center(
                                        child: SpinKitWanderingCubes(
                                          size: 50,
                                          color: Colors.black,
                                        ),
                                      ),),
                                      errorWidget: (context,url,error)=> Icon(Icons.error_outline , color: Colors.red,),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding:  EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),

                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                              Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(

                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),

                                            ],

                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
