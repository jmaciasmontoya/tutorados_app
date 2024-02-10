import 'package:flutter/material.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff80608B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xff80608B),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Registro de tutorados',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Text(
                  'Datos del estudiante',
                  style: TextStyle(color: Color(0xffffffff), fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff403046).withOpacity(0.20),
                      offset: const Offset(-4, -4),
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ],
                  color: const Color(0xffffffff),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      
                      topRight: Radius.circular(40))),
              child: const FormView(),
            ),
          )
        ],
      ),
    );
  }
}

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(child: FirstSectionOfStudentData()),
      ),
    );
  }
}
