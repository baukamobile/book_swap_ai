import 'package:book_swap_ai/components/bottomnavbar.dart';
import 'package:book_swap_ai/main.dart';
import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  String name = "Tom";
  String email = "tom@gmail.com";
  var phoneNumber = 77775456787;


  void register(context){
    Navigator.push(
      context,
       MaterialPageRoute(builder:(context)=>RegisterPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                  Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){
                    
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                  }, icon: Icon(Icons.exit_to_app))),
              ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                          height: 150,
                          child: CircleAvatar(
                          // width: 150,
                          // height: 150,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(40)),
                          // ),
                            child: Image(image: AssetImage('assets/img/avtr.jpg'))),
                      ),
                        //  Image.asset('assets/img/avtr.jpg')
                
                    
                  // const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('Name:'),
                          Text("$name"),
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('Email:'),
                          Text("$email"),
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('Phone Number:'),
                      Text("$phoneNumber"),
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                    ],
                  ),
                  const SizedBox(height: 20,),
                            ],
                  ),
                ),
              ]
            ),
          ),
        )
        
      // bottomNavigationBar: Bottomnavbar(),
      
      );
  }
}