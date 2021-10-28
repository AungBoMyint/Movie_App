import 'package:flutter/material.dart';
import 'package:movie_app/provider/change_provider.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget with PreferredSizeWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Get ChangeProvider's Instance
    final provider = Provider.of<ChangeProvider>(context);
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: TextField(
              maxLines: 1,
              cursorColor: Colors.white,
              controller: _controller,
              autofocus: true,
              onSubmitted: (value) {
                //We Add ChangeProvider's currentText and then it will notify to listener
                if (value.isNotEmpty && value != null) {
                  provider.addSearchText(value);
                }
              },
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                hintText: "Search Movies By Title",
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          )),
    );
  }
}
