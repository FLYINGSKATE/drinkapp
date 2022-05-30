import 'package:drinkapp/modals/DrinkModal.dart';
import 'package:drinkapp/network/ApiRepository.dart';
import 'package:drinkapp/view/DrinksDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SearchListScreen extends StatefulWidget {
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {

  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    searchTextEditingController.text = "";
    //getSearchResult("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Assignment',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drinks Search List'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: searchTextEditingController,
                onChanged: (String val){
                  getSearchResult(val);
                  setState(() {

                  });
                },),
                FutureBuilder <List<DrinkModal>?>(
                  future: getSearchResult(searchTextEditingController.text.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DrinkModal>? data = snapshot.data;
                      return
                        Container(

                            child: ListView.builder(
                              shrinkWrap: true,
                            itemCount: data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 75,
                                color: Colors.white,
                                child: Center(child: ListTile(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DrinksDetailsScreen(drinkModal:data![index])),
                                    );
                                  },
                                  leading: Icon(Icons.no_drinks),
                                  title: Text(data![index]?.strDrink??"Error In Name",textScaleFactor: 1.5,),
                                  subtitle: Text(data![index]?.strAlcoholic??"Error In Name",textScaleFactor: 1.5,),
                                ),
                                ),);
                            }
                        ));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default show a loading spinner.
                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future <List<DrinkModal>?> getSearchResult(String string) async {
    List<DrinkModal>? response = await ApiRepository().getDrinkMasters(searchTextEditingController.text);
    print(response);
    return response;
  }
}
