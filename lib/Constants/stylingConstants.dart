import 'package:flutter/material.dart';

const TextStyle titleTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 209, 194, 194),
);

const InputDecoration searchArea = InputDecoration(
  hintText: 'Search Products here',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(9.0)),
    borderSide: BorderSide(color: Color.fromARGB(255, 11, 194, 11)),
  ),
  filled: true,
  fillColor: Color.fromARGB(255, 102, 102, 102),
  hintStyle: TextStyle(color: Color.fromARGB(255, 206, 206, 206)),
);

const TextStyle inputStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontFamily: AutofillHints.jobTitle,
);

const Icon searchIcon = Icon(
  Icons.search,
  color: Color.fromARGB(255, 11, 194, 11),
  size: 30.0,
);

const BoxDecoration for_footer = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: const Color.fromARGB(255, 130, 0, 153),
      width: 5.0,
    ),
  ),
);
