import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                  alignment: Alignment.bottomLeft,
                  width: double.infinity,

                   color:  Color(0xff54759E),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 120,),
                      Text("veer jalla valo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Text("+91 9876543210",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),flex: 3,),
                Expanded(child: Container(
                  color: Colors.white,
                  child:Padding(
                    padding: EdgeInsets.all(15),
                   child:   Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people),
                              const SizedBox(width: 20,),
                              Text("New Group"),
                            ],
                          ),
                          const SizedBox(height:15),
                          Row(
                            children: [
                              Icon(Icons.person),
                              const SizedBox(width: 20,),
                              Text("Contact"),
                            ],
                          ),
                          const SizedBox(height:15),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              const SizedBox(width: 20,),
                              Text("Calls"),
                            ],
                          ),
                          const SizedBox(height:15),
                          Row(
                            children: [
                              Icon(Icons.bookmark),
                              const SizedBox(width: 20,),
                              Text("Saved Messages"),
                            ],
                          ),
                          const SizedBox(height:15),
                          Row(
                            children: [
                              Icon(Icons.settings),
                              const SizedBox(width: 20,),
                              Text("Settings"),
                            ],
                          ),
                        ],
                      ),
                    
                  ),
                ),flex: 10,),
              ],
            ),
          );

  }
}
