import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FormScreen extends ConsumerWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codeState = ref.watch(codeProvider);
    final formState = ref.watch(formProvider);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Registro de tutorados',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 24,
                    )),
                const SizedBox(
                  height: 10,
                ),
                (codeState.tutor != null)
                    ? Text(
                        'Tutor: ${codeState.tutor?.name} ${codeState.tutor?.lastName}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                formState.section == 0
                    ? Container()
                    : LinearPercentIndicator(
                        animation: true,
                        animateFromLastPercent: true,
                        animationDuration: 1000,
                        percent: formState.loadingBar,
                        progressColor: const Color(0xff5A4361),
                        backgroundColor: const Color(0xffffffff),
                        barRadius: const Radius.circular(10),
                        trailing: Text(
                          '${formState.percentageCompleted}%',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
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

class FormView extends ConsumerWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(child: renderView(formState.section)),
      ),
    );
  }

  renderView(int section) {
    switch (section) {
      case 0:
        return const AssignTutor();
      case 1:
        return const FirstSectionOfStudentData();
      case 2:
        return const SecondSectionOfStudentData();
      case 3:
        return const ContactInformationSection();
      case 4:
        return const MedicalDataSection();
      case 5:
        return const AcademicDataSection();
      case 6:
        return const SocioeconomicDataSection();
      case 7:
        return const UploadPhoto();
      default:
        return const FormCompletedFeedback();
    }
  }
}
