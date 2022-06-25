// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:t2/widgets/drawer_widget.dart';
// import 'package:uuid/uuid.dart';
// import 'package:workos_arabic/constants/constants.dart';
// import 'package:workos_arabic/services/global_method.dart';
// import 'package:workos_arabic/widgets/comments_widget.dart';
//
// import 'constants/constants.dart';
//
// class TaskDetails extends StatefulWidget {
//   final String taskId;
//   final String uploadedBy;
//
//   const TaskDetails({required this.taskId, required this.uploadedBy});
//
//   @override
//   _TaskDetailsState createState() => _TaskDetailsState();
// }
//
// class _TaskDetailsState extends State<TaskDetails> {
//   bool _isCommenting = false;
//   var contentsInfo = TextStyle(
//       fontWeight: FontWeight.normal, fontSize: 15, color: Constants.darkBlue);
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? _authorName;
//   String? _authorPosition;
//   String? taskDescription;
//   String? taskTitle;
//   bool? _isDone;
//   Timestamp? postedDateTimeStamp;
//   Timestamp? deadlineDateTimeStamp;
//   String? deadlineDate;
//   String? postedDate;
//   String? userImageUrl;
//   bool isDeadlineAvailable = false;
//   bool _isLoading = false;
//   TextEditingController _commentController = TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     _commentController.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   void getData() async {
//     try {
//       _isLoading = true;
//       final DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.uploadedBy)
//           .get();
//       if (userDoc == null) {
//         return;
//       } else {
//         setState(() {
//           _authorName = userDoc.get('name');
//           _authorPosition = userDoc.get('positionInCompany');
//           userImageUrl = userDoc.get('userImageUrl');
//         });
//       }
//       final DocumentSnapshot taskDatabase = await FirebaseFirestore.instance
//           .collection('tasks')
//           .doc(widget.taskId)
//           .get();
//       if (taskDatabase == null) {
//         return;
//       } else {
//         setState(() {
//           taskDescription = taskDatabase.get('taskDescription');
//           _isDone = taskDatabase.get('isDone');
//           deadlineDate = taskDatabase.get('deadlineDate');
//           deadlineDateTimeStamp = taskDatabase.get('deadlineDateTimeStamp');
//           postedDateTimeStamp = taskDatabase.get('createdAt');
//           var postDate = postedDateTimeStamp!.toDate();
//           postedDate = '${postDate.year}-${postDate.month}-${postDate.day}';
//           var date = deadlineDateTimeStamp!.toDate();
//           isDeadlineAvailable = date.isAfter(DateTime.now());
//         });
//       }
//     } catch (error) {
//       GlobalMethods.showErrorDialog(
//           error: 'An error occured', context: context);
//     } finally {
//       _isLoading = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         title: TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             'Back',
//             style: TextStyle(
//                 color: Constants.darkBlue,
//                 fontStyle: FontStyle.italic,
//                 fontSize: 20),
//           ),
//         ),
//       ),
//       body: _isLoading
//           ? Center(
//               child: Text(
//                 'Fetching data',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: Text(
//                       taskTitle == null ? '' : taskTitle!,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30,
//                           color: Constants.darkBlue),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'uploaded by',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                       color: Constants.darkBlue),
//                                 ),
//                                 Spacer(),
//                                 Container(
//                                   height: 50,
//                                   width: 50,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       width: 3,
//                                       color: Colors.pink.shade800,
//                                     ),
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                         image: NetworkImage(
//                                           userImageUrl == null
//                                               ? 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'
//                                               : userImageUrl!,
//                                         ),
//                                         fit: BoxFit.fill),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       _authorName == null ? '' : _authorName!,
//                                       style: contentsInfo,
//                                     ),
//                                     Text(
//                                       _authorPosition == null
//                                           ? ''
//                                           : _authorPosition!,
//                                       style: contentsInfo,
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Uploaded on:',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                       color: Constants.darkBlue),
//                                 ),
//                                 Text(
//                                   postedDate == null ? '' : postedDate!,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.normal,
//                                       fontSize: 15,
//                                       color: Constants.darkBlue),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Deadline date:',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                       color: Constants.darkBlue),
//                                 ),
//                                 Text(
//                                   deadlineDate == null ? '' : deadlineDate!,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.normal,
//                                       fontSize: 15,
//                                       color: Colors.red),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Center(
//                               child: Text(
//                                 isDeadlineAvailable
//                                     ? 'Still have enough time'
//                                     : "No time left",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 15,
//                                     color: isDeadlineAvailable
//                                         ? Colors.green
//                                         : Colors.red),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'Done state:',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Constants.darkBlue),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Flexible(
//                                     child: TextButton(
//                                   child: Text('Done',
//                                       style: TextStyle(
//                                           decoration: _isDone == true
//                                               ? TextDecoration.underline
//                                               : TextDecoration.none,
//                                           fontWeight: FontWeight.normal,
//                                           fontSize: 15,
//                                           color: Constants.darkBlue)),
//                                   onPressed: () {
//                                     User? user = _auth.currentUser;
//                                     String _uid = user!.uid;
//                                     if (_uid == widget.uploadedBy) {
//                                       FirebaseFirestore.instance
//                                           .collection('tasks')
//                                           .doc(widget.taskId)
//                                           .update({'isDone': true});
//                                       getData();
//                                     } else {
//                                       print('ds');
//                                       // GlobalMethods.showErrorDialog(
//                                       //     error:
//                                       //     'You can\'t perform this action',
//                                       //     context: context);
//                                     }
//                                   },
//                                 )),
//                                 Opacity(
//                                   opacity: _isDone == true ? 1 : 0,
//                                   child: Icon(
//                                     Icons.check_box,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 40,
//                                 ),
//                                 Flexible(
//                                     child: TextButton(
//                                   child: Text('Not done',
//                                       style: TextStyle(
//                                         decoration: _isDone == false
//                                             ? TextDecoration.underline
//                                             : TextDecoration.none,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 15,
//                                         color: Constants.darkBlue,
//                                       )),
//                                   onPressed: () {
//                                     User? user = _auth.currentUser;
//                                     String _uid = user!.uid;
//                                     if (_uid == widget.uploadedBy) {
//                                       FirebaseFirestore.instance
//                                           .collection('tasks')
//                                           .doc(widget.taskId)
//                                           .update({'isDone': false});
//                                       getData();
//                                     } else {
//                                       // GlobalMethods.showErrorDialog(
//                                       //     error:
//                                       //     'You can\'t perform this action',
//                                       //     context: context);
//                                       print('d');
//                                     }
//                                   },
//                                 )),
//                                 Opacity(
//                                   opacity: _isDone == false ? 1 : 0,
//                                   child: Icon(
//                                     Icons.check_box,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'Task description:',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Constants.darkBlue),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               taskDescription == null ? '' : taskDescription!,
//                               style: TextStyle(
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 15,
//                                 color: Constants.darkBlue,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             AnimatedSwitcher(
//                               duration: Duration(milliseconds: 500),
//                               child: _isCommenting
//                                   ? Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Flexible(
//                                           flex: 3,
//                                           child: TextField(
//                                             maxLength: 200,
//                                             controller: _commentController,
//                                             style: TextStyle(
//                                               color: Constants.darkBlue,
//                                             ),
//                                             keyboardType: TextInputType.text,
//                                             maxLines: 6,
//                                             decoration: InputDecoration(
//                                               filled: true,
//                                               fillColor: Theme.of(context)
//                                                   .scaffoldBackgroundColor,
//                                               enabledBorder:
//                                                   UnderlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.white),
//                                               ),
//                                               errorBorder: UnderlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.red),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.pink),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Flexible(
//                                             flex: 1,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   MaterialButton(
//                                                     onPressed: () async {
//                                                       if (_commentController
//                                                               .text.length <
//                                                           7) {
//                                                         // GlobalMethods
//                                                         //     .showErrorDialog(
//                                                         //     error:
//                                                         //     'Comment cant be less than 7 characteres',
//                                                         //     context:
//                                                         //     context);
//                                                         print('dd');
//                                                       } else {
//                                                         final _generatedId =
//                                                             Uuid().v4();
//                                                         await FirebaseFirestore
//                                                             .instance
//                                                             .collection('tasks')
//                                                             .doc(widget.taskId)
//                                                             .update({
//                                                           'taskComments':
//                                                               FieldValue
//                                                                   .arrayUnion([
//                                                             {
//                                                               'userId': widget
//                                                                   .uploadedBy,
//                                                               'commentId':
//                                                                   _generatedId,
//                                                               'name':
//                                                                   _authorName,
//                                                               'commentBody':
//                                                                   _commentController
//                                                                       .text,
//                                                               'time': Timestamp
//                                                                   .now(),
//                                                               'userImageUrl':
//                                                                   userImageUrl,
//                                                             }
//                                                           ]),
//                                                         });
//                                                         await Fluttertoast.showToast(
//                                                             msg:
//                                                                 "Task has been uploaded successfuly",
//                                                             toastLength: Toast
//                                                                 .LENGTH_LONG,
//                                                             gravity:
//                                                                 ToastGravity
//                                                                     .CENTER,
//                                                             fontSize: 16.0);
//                                                         _commentController
//                                                             .clear();
//                                                         setState(() {});
//                                                       }
//                                                     },
//                                                     color: Colors.pink.shade700,
//                                                     elevation: 10,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         13),
//                                                             side: BorderSide
//                                                                 .none),
//                                                     child: Padding(
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           vertical: 14),
//                                                       child: Text(
//                                                         'Post',
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             // fontSize: 20,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   TextButton(
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           _isCommenting =
//                                                               !_isCommenting;
//                                                         });
//                                                       },
//                                                       child: Text('Cancel')),
//                                                 ],
//                                               ),
//                                             ))
//                                       ],
//                                     )
//                                   : Center(
//                                       child: MaterialButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             _isCommenting = !_isCommenting;
//                                           });
//                                         },
//                                         color: Colors.pink.shade700,
//                                         elevation: 10,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(13),
//                                             side: BorderSide.none),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 14),
//                                           child: Text(
//                                             'Add a comment',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 // fontSize: 20,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             FutureBuilder<DocumentSnapshot>(
//                                 future: FirebaseFirestore.instance.collection('tasks').doc(widget.taskId).get(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState == ConnectionState.waiting) {
//                                     return Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   } else {
//                                     if (snapshot.data == null) {
//                                       return Container();
//                                     }
//                                   }
//                                   return ListView.separated(
//                                       reverse: true,
//                                       shrinkWrap: true,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       itemBuilder: (ctx, index) {
//                                         return CommentWidget(
//                                           commentId: snapshot.data!['taskComments'][index]['commentId'],
//                                           commentBody: snapshot.data!['taskComments'][index]['commentBody'],
//                                           commenterId: snapshot.data!['taskComments'][index]['userId'],
//                                           commenterName: snapshot.data!['taskComments'][index]['name'],
//                                           commenterImageUrl: snapshot.data!['taskComments'][index]['userImageUrl'],
//                                         );
//                                       },
//                                       separatorBuilder: (ctx, index) {
//                                         return Divider(
//                                           thickness: 1,
//                                         );
//                                       },
//                                       itemCount: snapshot.data!['taskComments'].length);
//                                 })
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
//
//
// }
// class CommentWidget extends StatelessWidget {
//   CommentWidget(
//       {Key? key,
//         required this.commentId,
//         required this.commentBody,
//         required this.commenterImageUrl,
//         required this.commenterName,
//         required this.commenterId});
//
//   final String commentId;
//   final String commentBody;
//   final String commenterImageUrl;
//   final String commenterName;
//   final String commenterId;
//   List<Color> _colors = [
//     Colors.orangeAccent,
//     Colors.pink,
//     Colors.amber,
//     Colors.purple,
//     Colors.brown,
//     Colors.blue,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     _colors.shuffle();
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 5,
//         ),
//         Flexible(
//           child: Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 2,
//                 color: _colors[3],
//               ),
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                   image: NetworkImage(
//                     commenterImageUrl,
//                   ),
//                   fit: BoxFit.fill),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 4,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   commenterName,
//                   style: TextStyle(
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   commentBody,
//                   style: TextStyle(
//                       fontStyle: FontStyle.italic, color: Colors.grey.shade700),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
//
//
//
//
//
//
// class TasksScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       drawer: DrawerWidget(),
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         // leading: Builder(
//         //   builder: (ctx) {
//         //     return IconButton(
//         //       icon: Icon(
//         //         Icons.menu,
//         //         color: Colors.red,
//         //       ),
//         //       onPressed: () {
//         //         Scaffold.of(ctx).openDrawer();
//         //       },
//         //     );
//         //   },
//         // ),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: Text(
//           'Tasks',
//           style: TextStyle(color: Colors.pink),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showTaskCategoryDialog(context, size);
//             },
//             icon: Icon(
//               Icons.filter_list_outlined,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data!.docs.isNotEmpty) {
//               return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return TaskWidget(
//                       taskTitle: snapshot.data!.docs[index]['taskTitle'],
//                       taskDescription: snapshot.data!.docs[index]
//                       ['taskDescription'],
//                       taskId: snapshot.data!.docs[index]['taskId'],
//                       uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
//                       isDone: snapshot.data!.docs[index]['isDone'],
//                     );
//                   });
//             } else {
//               return Center(
//                 child: Text('No tasks has been uploaded'),
//               );
//             }
//           }
//           return Center(
//             child: Text('Something went wrong'),
//           );
//         },
//       ),
//     );
//   }
//
//   void showTaskCategoryDialog(context, size) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(
//               'Task category',
//               style: TextStyle(color: Colors.pink.shade300, fontSize: 20),
//             ),
//             content: Container(
//               width: size.width * 0.9,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: Constants.taskCategoryList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () {
//                         print(
//                             'taskCategoryList[index] ${Constants.taskCategoryList[index]}');
//                       },
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.check_circle_rounded,
//                             color: Colors.red[200],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               Constants.taskCategoryList[index],
//                               style: TextStyle(
//                                   color: Color(0xFF00325A),
//                                   fontSize: 20,
//                                   // fontWeight: FontWeight.bold,
//                                   fontStyle: FontStyle.italic),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.canPop(context) ? Navigator.pop(context) : null;
//                 },
//                 child: Text('Close'),
//               ),
//               TextButton(onPressed: () {}, child: Text('Cancel filter'))
//             ],
//           );
//         });
//   }
// }
//
// class TaskWidget extends StatefulWidget {
//   final String taskTitle;
//   final String taskDescription;
//   final String taskId;
//   final String uploadedBy;
//   final bool isDone;
//
//   const TaskWidget(
//       {required this.taskTitle,
//         required this.taskDescription,
//         required this.taskId,
//         required this.uploadedBy,
//         required this.isDone});
//   @override
//   _TaskWidgetState createState() => _TaskWidgetState();
// }
//
// class _TaskWidgetState extends State<TaskWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8.0,
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       child: ListTile(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TaskDetails(uploadedBy: '', taskId: '',),
//             ),
//           );
//         },
//         onLongPress: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   actions: [
//                     TextButton(
//                         onPressed: () {},
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               'Delete',
//                               style: TextStyle(
//                                 color: Colors.red,
//                               ),
//                             )
//                           ],
//                         ))
//                   ],
//                 );
//               });
//         },
//         contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         leading: Container(
//           padding: EdgeInsets.only(right: 12.0),
//           decoration: BoxDecoration(
//             border: Border(
//               right: BorderSide(width: 1.0),
//             ),
//           ),
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius:
//             20, // https://image.flaticon.com/icons/png/128/850/850960.png
//             child: Image.network(widget.isDone
//                 ? 'https://image.flaticon.com/icons/png/128/390/390973.png'
//                 : 'https://image.flaticon.com/icons/png/128/850/850960.png'),
//           ),
//         ),
//         title: Text(
//           widget.taskTitle,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(
//               Icons.linear_scale,
//               color: Colors.pink.shade800,
//             ),
//             Text(
//               widget.taskDescription,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//         trailing: Icon(
//           Icons.keyboard_arrow_right,
//           size: 30,
//           color: Colors.pink[800],
//         ),
//       ),
//     );
//   }
// }
