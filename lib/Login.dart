import 'package:flutter/material.dart';
import 'package:make_my_show/Home.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255), 
     
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(" LOGIN ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent),),
              const SizedBox(height: 20,),

              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 5,bottom: 15),
                  child: Text("Welcome Back",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                  )
                ],
              ),
              const TextField(
                
                // controller: UserController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                  hintText: "Enter Username",
                  prefixIcon: Icon(Icons.account_box)
                ),
              ),
              const SizedBox(height: 20,),
              const TextField(
                // controller: UserController,
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter Password",
                  prefixIcon: Icon(Icons.password_sharp)
                ),
              ),
                const SizedBox(height: 20,),
              OutlinedButton(onPressed: (){
                Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: (context) =>  HOME()
                ));
              }, child: const Text("  Login  "))
            ],
          ),
        ),
      ),
    );
  }
}
