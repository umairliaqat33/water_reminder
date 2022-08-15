import 'package:flutter/material.dart';

const textFieldDecoration = InputDecoration(
  icon: null,
  label: null,
  // fillColor: Colors.white,
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 10,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);

/*For Later Use*/
//  addAlertDialogue(BuildContext context, double intake) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(
//             builder: (BuildContext context,
//                 void Function(void Function()) setState) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(18)),
//                 ),
//                 title: Text("Add Water"),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Field is required";
//                           }
//                           if (value == "0") {
//                             return "Quantity can not be 0";
//                           }
//                           if (double.parse(value) > intake) {
//                             return "This quantity exceeds your intake";
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.number,
//                         textInputAction: TextInputAction.done,
//                         controller: quantityController,
//                         decoration: textFieldDecoration.copyWith(
//                           icon: FaIcon(FontAwesomeIcons.water),
//                           label: Text(
//                             "Water Quantity",
//                             style: TextStyle(
//                                 color: Color(0xff4FA8C5), fontSize: 20),
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           TextButton(
//                               onPressed: () async {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                                 TimeOfDay? newTime = await showTimePicker(
//                                     context: context, initialTime: timeToDrink);
//                                 if (newTime == null) return;
//                                 setState(() {
//                                   timeToDrink = newTime;
//                                 });
//                                 print(timeToDrink.format(context));
//                               },
//                               child: Text(
//                                 "Select Time",
//                                 style: TextStyle(
//                                   color: Color(0xff4FA8C5),
//                                 ),
//                               )),
//                           Text(": ${timeToDrink.format(context)}"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text("Cancel")),
//                   TextButton(
//                       onPressed: () {
//
//                       },
//                       child: Text(
//                         "Add",
//                         style: TextStyle(
//                           color: Color(0xff4FA8C5),
//                         ),
//                       )),
//                 ],
//               );
//             },
//           );
//         });
//   }
