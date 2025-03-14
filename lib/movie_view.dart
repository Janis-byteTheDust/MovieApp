import 'package:flutter/material.dart';
import 'package:movie_app/alert.dart';
import 'package:movie_app/bottom_nav.dart';
import 'package:movie_app/moei.dart';
import 'package:movie_app/response_data_list.dart';
import 'package:movie_app/tambah_movie_view.dart';



class MovieView extends StatefulWidget {
  const MovieView({super.key});


  @override
  State<MovieView> createState() => _MovieViewState();
}


class _MovieViewState extends State<MovieView> {
MovieService movie = MovieService();
List action = ["Update", "Hapus"];
List? film;
getFilm() async {
    ResponseDataList getMovie = await movie.getMovie();
    setState(() {
      film = getMovie.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Movie"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TambahMovieView(title: "Tambah Movie", item:null, )));
              },
              icon: Icon(Icons.add))
        ],

      ),
      
      body: film != null
          ? ListView.builder(
              
              itemCount: film!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading:
                        Image(image: NetworkImage(film![index].posterPath)),
                     title: Text(film![index].title),
                    trailing:
                        PopupMenuButton(itemBuilder: (BuildContext context) {
                      return action.map((r) {
                        return PopupMenuItem(
                            onTap: () async {
                              if (r == "Update") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TambahMovieView(
                                            title: "Update Movie",
                                            item: film![index])));
                              } else {
                                var results = await AlertMessage()
                                    .showAlertDialog(context);
                                if (results != null &&
                                    results.containsKey('status')) {
                                  if (results['status'] == true) {
                                    var res = await movie.hapusMovie(
                                        context, film![index].id);
                                    if (res.status == true) {
                                      AlertMessage().showAlert(
                                          context, res.message, true);
                                      getFilm();
                                    } else {
                                      AlertMessage().showAlert(
                                          context, res.message, false);
                                    }
                                          }
                                }
                              }
                            },
                            value: r,
                            child: Text(r));
                      }).toList();
                    }),


                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
            
            
      bottomNavigationBar: BottomNav(1),
    );
    

  }
}
