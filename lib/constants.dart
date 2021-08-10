import 'files_export.dart';
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

// const kTextFieldDecoration = InputDecoration(
//   hintText: 'Enter a value',
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
//     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//   ),
// );
const kHeadingTextStyle = TextStyle(
color: Color(0xff1CB9d6),
fontSize: 20.0,
fontWeight: FontWeight.bold
);
const kTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold
);

const kHeadingTextStyles = TextStyle(
    color: Color(0xff1CB9d6),
    fontSize: 16.0,
    fontWeight: FontWeight.bold
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white10,
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 16.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
const kDefaultPadding = const EdgeInsets.only(bottom:20);
