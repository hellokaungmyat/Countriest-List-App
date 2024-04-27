import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_full_widget/api/api_service.dart';
import 'package:state_full_widget/model/country.dart';
 
import 'package:state_full_widget/screen/detail.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
      ),
      body: FutureBuilder<List<Country>>(
          future: apiService.getCountries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Country> country = snapshot.data ?? [];
              return ListView.builder(
                itemCount: country.length,
                itemBuilder: (context, index) {
                  return countrylist(country[index], context);
                },
              );
            } else if (snapshot.hasError) return const Center(child: Text('Error',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget countrylist(Country country, context) {
    return Card(
      child: ListTile(
        onTap: () {
         Get.to(DetailScreen(country.name));
        },
        leading: CachedNetworkImage(imageUrl: 'https://flagcdn.com/w40/${country.alpha2Code.toLowerCase()}.png',
        placeholder: (context, url) =>  const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        title: Text(country.name,style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(country.region,style: const TextStyle(color: Colors.blue),),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
