import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_app/modals.dart';
import 'package:platform_convertor_app/setting_page.dart';
import 'call_page.dart';
import 'chat_page.dart';
import 'my_drawer.dart';

void main() {
  runApp(const MyApp());
}

bool isIOS = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  double initialSliderVal = 0;
  String groupVal = "India";
  bool adaptiveSwitchVal = false;
  int _currentIndex = 0;
  int _currentStep = 0;
  ImagePicker _picker = ImagePicker();
  File? img;

  List myTabs = ["CHATS", "CALLS", "SETTINGS"];

  late TabController _tabController;
  PageController _pageController = PageController();
TextEditingController name =TextEditingController();
  TextEditingController discription =TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return (isIOS == false)
        ? MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: _currentIndex,
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: MyDrawer(),
          ),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: const Color(0xff54759E),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Stepper(
                        currentStep: _currentStep,
                        onStepTapped: (val) {
                          setState(() {
                            _currentStep = val;
                          });
                        },
                        controlsBuilder: (context, details) {
                          return Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff54759E),
                                ),
                                child: (_currentStep == 2)
                                    ? Text("ADD")
                                    : Text("CONTINUE"),
                                onPressed: () {
                                  setState(() {
                                    if(_currentStep==2)
                                      {
                                        setState(() {
                                          String time="${DateTime.now().hour}:${DateTime.now().minute} AM";
                                          User user1 =User(image: img.toString(), subtitle: discription.text, title: name.text, time: time, id: userlist.length+1);
                                          userlist.add(user1);
                                          Navigator.of(context).pop();
                                        });

                                      }
                                    if (_currentStep < 2) {
                                      _currentStep++;
                                    }
                                  });
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.grey,
                                ),
                                child: Text("CANCEL"),
                                onPressed: () {
                                  setState(() {
                                    if (_currentStep > 0) {
                                      _currentStep--;
                                    }
                                  });
                                },
                              ),
                            ],
                          );
                        },
                        steps: <Step>[
                          Step(
                            isActive: (_currentStep >= 0) ? true : false,
                            title: Text("PROFILE PHOTO"),
                            subtitle: Text("Add Profile Photo"),
                            content: Container(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(radius: 40),
                                 IconButton(onPressed: ()async{
                                   XFile? xfile = await _picker.pickImage(source: ImageSource.camera);
                                   String path = xfile!.path;
                                   File file = File(path);

                                   setState(() {
                                     img = file;
                                   });

                                 }, icon:  Icon(Icons.add),),
                                ],
                              ),
                            ),
                          ),
                          Step(
                            isActive: (_currentStep >= 1) ? true : false,
                            title: Text("Name"),
                            subtitle: Text("Enter Name"),
                            content: Container(
                              child: TextField(
                                controller: name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your name",
                                ),
                              ),
                            ),
                          ),
                          Step(
                            isActive: (_currentStep >= 2) ? true : false,
                            title: Text("Description"),
                            subtitle: Text("Enter Description"),
                            content: Container(
                              child: TextField(
                                controller: discription,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter description",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          appBar: AppBar(
            bottom: TabBar(
              onTap: (val) {
                _pageController.animateToPage(
                  val,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 400),
                );
                setState(() {
                  _currentIndex = val;
                });
              },
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 6,
              tabs: myTabs.map((e) => Tab(text: e)).toList(),
            ),
            backgroundColor: const Color(0xff54759E),
            title: const Text(
              "Platform Convertor",
            ),
            actions: [
              Switch(
                value: isIOS,
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() {
                    isIOS = val;
                  });
                },
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (val) {
              _tabController.animateTo(val);
              setState(() {
                _currentIndex = val;
              });
            },
            children: const [
              ChatPage(),
              CallPage(),
              SettingPage(),
            ],
          ),
        ),
      ),
    )
        : CupertinoApp(
      debugShowCheckedModeBanner: false,
      home:CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Builder(builder: (context) {
              return CupertinoButton(
                child: Icon(Icons.menu,color: Colors.grey,),
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return Row(
                          children: [
                            const Expanded(
                              flex: 7,
                              child: MyDrawer(),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
              );
            }),
            middle: const Text("Platform Convertor"),
            trailing: CupertinoSwitch(
              value: isIOS,
              activeColor: CupertinoColors.activeGreen,
              onChanged: (val) {
                setState(() {
                  isIOS = val;
                });
              },
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IndexedStack(
                  index: _currentIndex,
                  children: [
                    ChatPage(),
                    CallPage(),
                    SettingPage(),
                  ],
                ),
                Column(
                  children: [
                    Spacer(),
                    CupertinoTabBar(
                      currentIndex: _currentIndex,
                      onTap: (val) {
                        setState(() {
                          _currentIndex = val;
                        });
                      },
                      backgroundColor:
                      CupertinoColors.opaqueSeparator.withOpacity(0.5),
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.chat_bubble_2),
                          label: "Chats",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.phone),
                          label: "Calls",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.settings),
                          label: "Settings",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      /* CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Builder(builder: (context) {
            return CupertinoButton(
              child: Icon(Icons.menu),
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return Row(
                        children: [
                           Expanded(
                            flex: 7,
                            child: MyDrawer(),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            );
          }),
          middle: const Text("Platform Convertor"),
          trailing: CupertinoSwitch(
            value: isIOS,
            activeColor: CupertinoColors.activeGreen,
            onChanged: (val) {
              setState(() {
                isIOS = val;
              });
            },
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IndexedStack(
                index: _currentIndex,
                children: [
                  ChatPage(),
                  CallPage(),
                  SettingPage(),
                ],
              ),
              Column(
                children: [
                  Spacer(),
                  CupertinoTabBar(
                    currentIndex: _currentIndex,
                    onTap: (val) {
                      setState(() {
                        _currentIndex = val;
                      });
                    },
                    backgroundColor:
                    CupertinoColors.opaqueSeparator.withOpacity(0.5),
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chat_bubble_2),
                        label: "Chats",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.phone),
                        label: "Calls",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.settings),
                        label: "Settings",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}