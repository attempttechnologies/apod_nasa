import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_apod/business_logic/models/apod_model.dart';

void main(List<String> args) {
  runApp(const APOD());
}

// https://api.nasa.gov/
class APOD extends StatelessWidget {
  const APOD({Key? key}) : super(key: key);

  final String _apiKey = "nywcGd7AsZL9j79MvaiUkLRXuMMfVtFbfBWunAXT";
  final String _baseURL = "https://api.nasa.gov/planetary/apod?";

  Future<APODModel> _getAPOD() async {
    var respone = await http.get(
      Uri.parse("${_baseURL}api_key=$_apiKey"),
    );
    return APODModel.fromJSON(jsonDecode(respone.body));
  }

  @override
  Widget build(BuildContext context) {
    _getAPOD();
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<APODModel>(
          future: _getAPOD(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${snapshot.data!.title}"),
                      snapshot.data!.mediaType == "image"
                          ? Image.network(
                              ("${snapshot.data!.url}"),
                            )
                          : const Text(
                              "Video format not supported at this moment",
                            ),
                      Text("${snapshot.data!.explanation}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Copyright: ${snapshot.data!.copyright}"),
                          Text("Date: ${snapshot.data!.date}"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
