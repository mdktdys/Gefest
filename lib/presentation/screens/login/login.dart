import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 510),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png",width: 80,),
                  Text("Замены уксивтика",style:GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 34)),
                ],
              ),
              const SizedBox(height: 10,),
               Text("Вход",style:GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 20)),
              const SizedBox(height: 10,),
               Text("Введите свои данные для входа",style:GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 18)),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Colors.blue,width: 1),
                ),
                child:   Padding(padding: 
                  const EdgeInsets.all(28),
                  child: Column(
                    children: [
                       const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Почта"),
                          TextField(),
                        ],
                       ),
                       const SizedBox(height: 10,),
                       const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Пароль"),
                          TextField(),
                        ],
                       ),
                       const SizedBox(height: 20,),
                       InkWell(
                        onHover: (value) {
                          
                        },
                        onTap: () {
                          
                        },
                         child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child:  Center(child: Text("Войти",style: GoogleFonts.roboto(color: Colors.white),)),
                         ),
                       ),
                       const SizedBox(height: 20,),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("@mdktdys"),
                          Text("Забыл пароль?",style: GoogleFonts.roboto(color: Colors.blue),),
                        ],
                       )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}