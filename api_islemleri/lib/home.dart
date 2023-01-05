import 'dart:io';

import 'package:api_islemleri/Api_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  late final Dio dio;
  final basURL = 'https://jsonplaceholder.typicode.com';
  @override
  void initState() {
    super.initState();
    name = 'Api Operations';
    PostItems();
    dio = Dio(BaseOptions(baseUrl: basURL));
  }

  List<ApiModel>? items;

  Future<void> PostItems() async {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/photos');

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          items = _datas.map((e) => ApiModel.fromJson(e)).toList();
        });
      }
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(name ?? '')),
      ),
      body: ListView.builder(
        itemCount: items?.length ?? 0,
        itemBuilder: (context, index) {
          return postCard(model: items?[index]);
        },
      ),
    );
  }
}

class postCard extends StatelessWidget {
  const postCard({
    Key? key,
    this.model,
  }) : super(key: key);

  final ApiModel? model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(model?.title ?? ''),
        subtitle: Text(model?.thumbnailUrl ?? ''),
      ),
    );
  }
}
