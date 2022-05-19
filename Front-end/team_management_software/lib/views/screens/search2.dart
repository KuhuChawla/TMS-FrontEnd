import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team_management_software/views/components/card_project.dart';
import 'package:team_management_software/views/screens/search.dart';


class Search2 extends StatefulWidget {
  const Search2({Key? key}) : super(key: key);

  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  var searchController = TextEditingController();
  List searchList = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Container(
          padding: EdgeInsets.only(top:10),
          child: Text("Search 2 for instance",style: TextStyle(color: Colors.yellow[800],
              fontWeight: FontWeight.w300,
              fontSize: 24,
          ),),
        ),
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
              alignment: Alignment.topLeft,
              child: TabBar(

                indicatorWeight: 3,
                indicatorColor: Colors.yellow[800],
                isScrollable: true,
                tabs: const [
                  Tab(
                    text: 'People',
                    //height: 40,
                  ),
                  Tab(
                    text: 'Projects',
                  ),
                  Tab(
                    text: 'Tasks',
                  ),
                ],
              ),
            ),
          ),
        ),

        body:
            TabBarView(
              children: [
                SearchList(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 12
                    //  MediaQuery.of(context).size.height / 30
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                style: TextStyle(fontFamily: 'HelveticaBold'),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Search Projects",
                                  hintStyle: TextStyle(fontFamily: 'Helvetica'),
                                  prefixIcon: Icon(Icons.search_sharp,
                                      color: const Color(0xFF000000)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.0),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                    BorderSide(width: .0, color: Colors.yellow),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xFF000000),
                              ),
                              child: MaterialButton(
                                  textColor: Colors.purple,
                                  onPressed: () async {
                                    var url = Uri.parse(
                                        'https://ems-heroku.herokuapp.com/projects/search?name=${searchController.text}');
                                    var response = await http.get(url);
                                    if (response.statusCode == 200) {
                                      //print(response.body);

                                      setState(() {
                                        var mapResponse = json.decode(response.body);
                                        var searchResponse = mapResponse['data'];
                                        print(searchResponse);
                                        searchList = searchResponse;
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Search',
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.yellow[800],
                                        fontFamily: 'HelveticaBold'),
                                  )),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: searchList.length,
                          itemBuilder: (context, index) {
                            var data = searchList[index];
                            return Container(
                                child: CardForProject(
                                  name: data["name"] ?? "name",
                                  description: data["description"] ?? "description",
                                  projectId: data["_id"],
                                  index: index,
                                  isArchived: data["isArchived"],
                                  isFav: data["isFav"],
                                  completionRatio: data["completionRatio"] ?? 1,
                                ));
                          })
                    ],
                  ),
                ),

                Container(
                  child:Text("this is for tab view")
                ),


              ],
            )


      ),
    );
  }
}
