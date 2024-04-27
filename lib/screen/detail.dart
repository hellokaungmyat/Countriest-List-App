import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_full_widget/api/api_service.dart';
import 'package:state_full_widget/model/detail.dart';

class DetailScreen extends StatelessWidget {
  final ApiService apiservice=Get.find();
  final String country_name;
  DetailScreen( this.country_name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: FutureBuilder<List<Detail>>(
            future: apiservice.getDeatil(country_name),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Detail detail = snapshot.data![0];

                return ListView(
                  children: [
                    CachedNetworkImage(imageUrl: 
                      'https://flagcdn.com/w640/${detail.alpha2Code.toLowerCase()}.png',
                      placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
                      
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                       
                      errorWidget: (context, url, error) => const Text('Error'),
                    ),
                    Card(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              infoText('Country name: ${detail.name}', Colors.black),
                        infoText('Region: ${detail.region}', Colors.black),
                        infoText('Subregion: ${detail.subregion}', Colors.black),
                        infoText('Population: ${detail.population}', Colors.black),
                        infoText(
                            'Demonym: ${detail.demonym}'.toString(), Colors.black),
                          ],
                        ),
                      ),
                    )
              
                  ],
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error: '));
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

Widget infoText(message, color) {
  return Text(
    message,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: color),
  );
}
