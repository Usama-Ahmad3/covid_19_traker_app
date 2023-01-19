import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'Models/Country.dart';
import 'country_details.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<StatefulWidget> createState() => DetailsState();
}
class DetailsState extends State<Details>{
  var controler = TextEditingController();
  Future<Country> getApiResponce () async {
    final response = await http.get(Uri.parse('https://api.covid19api.com/summary'));
    // ignore: prefer_typing_uninitialized_variables
    var data;
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      return Country.fromJson(data);
    }
    else{
      return Country.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: controler,
              onChanged: (value){
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search From Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              )
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getApiResponce(),
                builder: (context,AsyncSnapshot<Country> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child:ListTile(
                        leading: Container(height: 50,width: 89,color: Colors.green,),
                        title: Container(height: 10,width: 89,color: Colors.green,),
                        subtitle: Container(height: 10,width: 89,color: Colors.green,),
                      ) ,
                    ));
                  }
                  else{
                       return ListView.builder(
                         itemCount: snapshot.data!.countries!.length,
                         itemBuilder: (context, index) {
                           String name = snapshot.data!.countries![index].country.toString();
                         if(controler.text.isEmpty){
                           return InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetails(name: snapshot.data!.countries![index].country.toString(),
                                 country: snapshot.data!.countries![index].country.toString(),
                                 countryCode: snapshot.data!.countries![index].countryCode.toString(),
                                 date: snapshot.data!.countries![index].date.toString(),
                                 newDeaths: int.parse(snapshot.data!.countries![index].newDeaths.toString(),),
                                 totalDeaths: int.parse(snapshot.data!.countries![index].totalDeaths.toString(),),
                                 totalConfirmed: int.parse(snapshot.data!.countries![index].totalConfirmed.toString(),),
                                 totalRecovered: int.parse(snapshot.data!.countries![index].totalRecovered.toString(),),
                               )));
                             },
                             child: Card(
                             elevation: 2,
                             shadowColor: Colors.grey,
                             child: ListTile(
                             subtitle: Text('Total Cases Are : ${snapshot.data!.countries![index].totalConfirmed}'),
                             title: Text(snapshot.data!.countries![index].country.toString(),style: const TextStyle(fontSize: 20),),
                             leading: Text(snapshot.data!.countries![index].countryCode.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              ),),
                           );
                           }
                         else if(name.toLowerCase().contains(controler.text.toLowerCase())){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetails(name: snapshot.data!.countries![index].country.toString(),
                                country: snapshot.data!.countries![index].country.toString(),
                                countryCode: snapshot.data!.countries![index].countryCode.toString(),
                                date: snapshot.data!.countries![index].date.toString(),
                                newDeaths: int.parse(snapshot.data!.countries![index].newDeaths.toString(),),
                               totalDeaths: int.parse(snapshot.data!.countries![index].totalDeaths.toString(),),
                                totalRecovered: int.parse(snapshot.data!.countries![index].totalRecovered.toString(),),
                                totalConfirmed: int.parse(snapshot.data!.countries![index].totalConfirmed.toString()),
                              ),));
                            },
                            child: Card(
                               elevation: 2,
                               shadowColor: Colors.grey,
                               child: ListTile(
                                 subtitle: Text('Total Cases Are : ${snapshot.data!.countries![index].totalConfirmed}'),
                                 title: Text(snapshot.data!.countries![index].country.toString(),style: const TextStyle(fontSize: 20),),
                                 leading: Text(snapshot.data!.countries![index].countryCode.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                               ),),
                          );
                         }
                         else{
                           return Container();
                         }
                         });
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ignore: must_be_immutable
class UseAbleRow extends StatelessWidget {
  String? country;
  String? code;
  String? total;
  UseAbleRow({Key? key,required this.country,required this.total,required this.code}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListTile(
          leading: Text(code!),
          title: Text(country!),
          subtitle: Text(total!),
        )
      ],
    );
  }
}
