import 'package:flutter/material.dart';
import 'package:note/features/add_note/z_image.dart';
import 'package:note/features/add_note/z_record.dart';

class TabBar1 extends StatefulWidget {
  TabBar1({super.key});

  @override
  State<TabBar1> createState() => _TabBarState();
}

class _TabBarState extends State<TabBar1> {
  final List<String> tabbaritem = ['Note', 'Images', 'Videos', 'File'];

  int current = 0;
  List<Widget> addhome = [Zimage(), Zrecord(), Zimage(), Zrecord()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 194, 194),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: tabbaritem.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                              color: current == index
                                  ? const Color.fromARGB(197, 255, 255, 255)
                                  : const Color.fromARGB(112, 255, 255, 255),
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: Colors.deepPurpleAccent, width: 2)
                                  : null),
                          child: Center(
                              child: Text(
                            '${tabbaritem[index]}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: current == index
                                    ? Colors.black
                                    : Colors.grey),
                          )),
                        ),
                      ),
                      Visibility(
                          visible: current == index,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurpleAccent),
                          ))
                    ],
                  );
                },
              ),
            ),
// Body
            Container(
              //height: 400,
              //width: double.infinity,
              child: Column(children: [addhome[current]]),
            )
          ],
        ),
      )),
    );
  }
}
