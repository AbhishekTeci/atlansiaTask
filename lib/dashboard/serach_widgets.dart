import 'package:flutter/material.dart';

class SearchWidgetView extends StatelessWidget {

  SearchWidgetView(
      {Key? key,
        required this.txtController,
        required this.onSubmitted,})
      : super(key: key);
  final TextEditingController txtController;
  final Function(String value) onSubmitted;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1,color: Colors.white),
          borderRadius: const BorderRadius.all(
              Radius.circular(30.0) //                 <--- border radius here
          ),
        ),
        padding:const EdgeInsets.only(left: 16.0, right: 16.0),
        height: 45.0,
        child: Center(
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search By Name',
                        hintStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w200)),
                    cursorColor: Colors.black,
                    onSubmitted: (value){
                      debugPrint('myValue1 $value');
                      onSubmitted(value);
                    },


                  )),
            ],
          ),
        ),
      ),
    );
  }
}



