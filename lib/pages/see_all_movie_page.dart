import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/model/parser.dart';
import 'package:movie_app/network_http/http_request.dart';
import 'package:movie_app/resuable_widget/each_movie_widget_for_seeall.dart';

class SellAllMoviesPage extends StatefulWidget {
  final String endPoint;
  final Map<String, dynamic> extraQuery;
  final String title;
  const SellAllMoviesPage(
      {Key? key,
      required this.endPoint,
      this.extraQuery = const {},
      required this.title})
      : super(key: key);

  @override
  _SellAllMoviesState createState() => _SellAllMoviesState();
}

class _SellAllMoviesState extends State<SellAllMoviesPage> {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    //Request New Page Everytime User Scroll Down
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      ///Request Movies List From API
      final result = await HTTPRequest(
              endPoint: widget.endPoint,
              extraQuery: {"page": pageKey}..addAll(widget.extraQuery))
          .executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
      final totalPage = result.total_pages;

      ///If current page is equal to total page,we do Schedule For Next Request
      if (result.page == totalPage) {
        _pagingController.appendLastPage(result.results);
      }

      ///OR we Schedule For Next Request
      else {
        int nextPageKey = result.page + 1;
        _pagingController.appendPage(result.results, nextPageKey);
      }
    } catch (err) {
      _pagingController.error = err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        ///For Each Title that Dynamically can change depand on which screen call this.
        title: Text(widget.title,
            style: GoogleFonts.lobster(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
      ),
      body: RefreshIndicator(
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
    );
  }
}
