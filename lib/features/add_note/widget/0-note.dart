import 'package:flutter/material.dart';
import 'package:note/core/service/sqldb.dart';
import 'package:note/core/widget/Custom_Text_FormField.dart';

class NoteWidge extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;
   NoteWidge({super.key, 
    required this.titleController,
    required this.noteController,
    //  this.noteid,
  });

  SqlDb mysql = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Custom_TextField(
              
              fontsize: 25, fontcolor: Colors.black,
              fontWeight: FontWeight.w900,
              border: InputBorder.none,
              controllerl: titleController,
              // border: InputBorder.none,
              HHintText: 'Title..',
              HHintSize: 25,
            ),
            const SizedBox(
              height: 15,
            ),
            Custom_TextField(
            
              border: InputBorder.none,
              controllerl: noteController,
              HHintText: 'Enter Note..',
              HHintSize: 17,
              fontsize: 17,
              fontcolor: const Color.fromARGB(255, 34, 34, 34),
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
