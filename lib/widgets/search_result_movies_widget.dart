import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/model/parser.dart';
import 'package:movie_app/network_http/http_request.dart';
import 'package:movie_app/resuable_widget/each_movie_widget_for_seeall.dart';

class SearchResultMoviesWidget extends StatefulWidget {
  final String endPoint;
  final queryParemeter;
  const SearchResultMoviesWidget(
      {Key? key, required this.endPoint, required this.queryParemeter})
      : super(key: key);

  @override
  _SearchResultMoviesWidgetState createState() =>
      _SearchResultMoviesWidgetState();
}

class _SearchResultMoviesWidgetState extends State<SearchResultMoviesWidget> {
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
              extraQuery: {"page": pageKey}..addAll(widget.queryParemeter))
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
    return RefreshIndicator(
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
    );
  }
}
