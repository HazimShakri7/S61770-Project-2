/* Author: Hazim Shakri
   Date: 30/12/2023, Time: 4:02 PM
   Purpose: To create a A4Profile for Tourist Helper Application
*/
import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';


class Question_Answer extends StatelessWidget {
final String username;

  const Question_Answer({super.key, required this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 123, 210, 241),
              Color.fromARGB(255, 123, 210, 241),
              
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
        //bottom container
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10.0),
            color: Colors.blue[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q & A',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
            // Questions and Answers
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  buildQuestionAnswerTile(
                    'How do I register a new place?',
                    'To register a new place, go to the "Registered Place" section and follow the instructions to add your location.',
                  ),
                  buildQuestionAnswerTile(
                    'Can I edit my registered place details?',
                    'Yes, you can edit your registered place details by navigating to the "Registered Place" section and selecting the place you want to edit.',
                  ),
                  buildQuestionAnswerTile(
                    'Is the Tourist Helper app free to use?',
                    'Yes, the Tourist Helper app is completely free to use and does not require any subscription fees.',
                  ),
                  buildQuestionAnswerTile(
                    'How can I contact customer support?',
                    'You can contact customer support by visiting the "Contact Us" section and sending an email with your inquiry.',
                  ),
                  buildQuestionAnswerTile(
                    'Are my registered places visible to other users?',
                    'No, your registered places are private and not visible to other users. They are only accessible from your account.',
                  ),
                ],
              ),
            ),

            // Rectangle box at the bottom with home icons and text
            buildBottomBar(context),
          ],
        ),
      ),
      endDrawer: MyDrawer(username: username,),
    );
  }

  Widget buildQuestionAnswerTile(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}