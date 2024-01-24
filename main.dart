import 'quize_brain.dart';
import 'question.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {


  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Widget> scorekeeper = [];
  QuizeBrain quizeBrain = QuizeBrain();


  void answerchecker(bool useranswer){

      bool correctanswer = quizeBrain.getanswer()!;
      setState(() {
        //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
        //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
        if (quizeBrain.isFinished() == true) {
          //TODO Step 4 Part A - show an alert using rFlutter_alert,

          //This is the code for the basic alert from the docs for rFlutter Alert:
          //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

          //Modified for our purposes:
          Alert(
            context: context,
            title: 'Finished!',
            style:AlertStyle(
              backgroundColor: Colors.red
            ),


            desc: 'You\'ve reached the end of the quiz.',
          ).show();

          //TODO Step 4 Part C - reset the questionNumber,
          quizeBrain.reset();

          //TODO Step 4 Part D - empty out the scoreKeeper.
          scorekeeper = [];
        }


        //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
        else {
          if (useranswer == correctanswer) {
            scorekeeper.add(Icon(Icons.check, color: Colors.green),);
          }
          else {
            scorekeeper.add(Icon(Icons.close, color: Colors.red,),);
          }
        }
        
        quizeBrain.nextquestion();
      });




      //The user picked false.
  }
 // List<String> questions = [
  //  'You can lead a cow down stairs but not up stairs.',
 //    'Approximately one quarter of human bones are in the feet.',
  //  'A slug\'s blood is green.'
  //];
  //List<bool> answers = [
 //   false,
  //  true,
 //   true
//  ];

//List<Question> questionBank = [
  //Question(q: 'You can lead a cow down stairs but not up stairs.',a:false ),
 // Question(q: 'Approximately one quarter of human bones are in the feet.',a:true ),
 // Question(q:'A slug\'s blood is green.',a: true )
//];


  int questionnumber =0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                //TODO we assign index number for list of questions which starts from zero
                quizeBrain.getquestion()!,

                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),

              ),
              onPressed: () {
                answerchecker(true);




                //TODO: refer chat gpt search history to know about non nullable constarints


                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                answerchecker(false);




                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
