import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:movie_app/model/json_model/movie.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/model/json_parser/movies_with_something_parser.dart';
import 'package:movie_app/network_http/http_request.dart';
import 'package:movie_app/resuable_widget/each_movie_widget_for_seeall.dart';


class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  late final FloatingSearchBarController _controller;
  late final GetStorage dataBase;

  //Controller For Pagination Scroll
  final PagingController<int,Movie> _pagingController = PagingController(firstPageKey: 1);

  //Filter Record Item List
  List<dynamic> filterRecordItems = [];
  //User Current Search Text
  String? selectedText;
  ///Whenever user enter search,we find if it contain or not.
  void filterRecordMethod(String? value){
    final box = dataBase.read('history') as List<dynamic>;
    if(value != null && value.isNotEmpty){
      filterRecordItems = box.where((element) => element.toString().startsWith(value)).toList();
    }
    filterRecordItems = box.reversed.toList();
  }

  //We add when user submit search text into our database
  void addSearchText(String value){
    final box = dataBase.read('history') as List<dynamic>;
    if(box.contains(value)){
      box.removeWhere((element) => element.toString() == value);
      box.add(value);
      dataBase.write('history', box);
    }else{
      box.add(value);
      dataBase.write('history', box);
    }
    ///Refresh our pagination
    selectedText = value;
    _pagingController.refresh();
    //We need to call this because whenever database change we add it's data into this list to show on UI
    filterRecordMethod(null);
  }

  //Delete Method when user delete element into database
  void deleteItem(String value){
    final box = dataBase.read('history') as List<dynamic>;
    box.removeWhere((element) => element == value);
    dataBase.write('history', box);
    filterRecordItems = box;
  }

  //Fetching Next Page everytime user scroll down the end of the current page
  Future<void> _fetchPage(pageKey) async{
    try{
      final currentPage = await HTTPRequest(
          endPoint: "/search/movie",
          extraQuery: {
            'query': selectedText ?? '',
            'page': pageKey
          }
      ).executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
      final totalPage = currentPage.total_pages;
      if(currentPage.page == totalPage){
        _pagingController.appendLastPage(currentPage.results);
      }else{
        final nextPageKey = currentPage.page + 1;
        _pagingController.appendPage(currentPage.results, nextPageKey);
      }
    }catch(error){
      _pagingController.error = 'There is no movies';
    }
  }

  @override
  void initState() {
    _controller = FloatingSearchBarController();
    dataBase = GetStorage();
    if(!dataBase.hasData('history')){
      dataBase.write('history', []);
    }

    //Listener for page request when user scrolling down
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    filterRecordMethod(null);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
          controller: _controller,
          actions: [
            FloatingSearchBarAction.searchToClear()
          ],
          title: Text(selectedText ?? "Search Movies.."),
          onQueryChanged: (value) {
            setState(() {
              filterRecordMethod(value);
            });
          },
          onSubmitted: (value) {
            setState(() {
              addSearchText(value);
            });
            _controller.close();
          },
          body: selectedText == '' || selectedText == null ?
          Center(
            child: Image.asset('image/movie_search_background.png')
          ):
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                    () => _pagingController.refresh(),
              ),
              child: PagedListView<int, Movie>.separated(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                    animateTransitions: true,
                    itemBuilder: (context, item, index) =>
                        EachMovieWidgetForSeeAllWiget(movie: item)),
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
          builder: (context, trans) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                elevation: 4,
                color: Colors.grey.withOpacity(0.8),
                child: Builder(builder: (context) {
                  if (filterRecordItems.isEmpty && _controller.query.isEmpty) {
                    return const SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Searching....",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (filterRecordItems.isEmpty) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          addSearchText(_controller.query);
                        });
                        _controller.close();
                      },
                      leading: const Icon(Icons.timeline),
                      title: Text(
                        _controller.query,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteItem(_controller.query);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    );
                  } else {
                    return Column(
                      children: filterRecordItems.map((element) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              addSearchText(element);
                            });
                            _controller.close();
                          },
                          leading: const Icon(Icons.timeline),
                          title: Text(
                            element,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  deleteItem(element);
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                        );
                      }).toList(),
                    );
                  }
                }),
              ),
            );
          }),
    );
  }
}
