// ignore_for_file: prefer_const_constructors, unused_element, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/post_model.dart';
import '../services/http_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());

    setState(
      () {
        isLoading = false;

        if (response != null) {
          items = Network.parsePostList(response);
        } else {
          items = [];
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SetState"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(
                items[index],
              );
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _apiPostList();
            },
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Delate",
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Update",
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title.toUpperCase()),
            SizedBox(
              height: 5,
            ),
            Text(post.title.toUpperCase()),
          ],
        ),
      ),
    );
  }
}
