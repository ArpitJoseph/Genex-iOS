//
//  File.swift
//  
//
//  Created by Arpit Joseph  on 02/12/22.
//

import Foundation

class FeedBack {
    
    private var impAnglesTable: String
  
    private var feedbackTable: String

    private var feedbackAnglesTable: String

    
    init() {
//        var homePath = System.getProperty("user.
        
        // Load Important Angles
        var fileName = "Important Angles Sheet.csv"
        
        try {
            //            val fileReader = BufferedReader(FileReader("$homePath/$fileName"))
            var fileReader = context.assets.open(fileName).bufferedReader()
            
            while (true) {
                var line = fileReader.readLine()
                var tokens = line.split(",")
                impAnglesTable[mutableListOf(tokens[0])] = mutableListOf(tokens[1])
            }
            debugPrint("GenexSDK", impAnglesTable)
        } catch (e) {
            debugPrint("genex_android_feedback")
        }
        
    }
    // Load Feedback
         var fileName = "Feedback Sheet.csv"
          
          try {
  //            val fileReader = BufferedReader(FileReader("$homePath/$fileName"))
              var fileReader = context.assets.open(fileName).bufferedReader()

              while (true) {
                  var line = fileReader.readLine() ?: break
                  var tokens = line.split(",")
                  feedbackTable[mutableListOf(tokens[0], tokens[1], tokens[2])] =
                      mutableListOf(tokens[3], tokens[4])
              }
              Log.d("GenexSDK", feedbackTable.toString())
              
          } catch (e: Exception) {
              Log.e("genex_android_feedback", e.printStackTrace().toString())
          }

          // Load Feedback Angles
          var fileNames = "Feedback Angles Sheet.csv"
        
          try {
  //            val fileReader = BufferedReader(FileReader("$homePath/$fileName"))
              var fileReader = context.assets.open(fileName).bufferedReader()

              while (true) {
                  var line = fileReader.readLine() ?: break
                  var tokens = line.split(",")
                  feedbackAnglesTable[mutableListOf(tokens[0], tokens[1], tokens[2], tokens[3])] =
                      mutableListOf(tokens[4])
              }
              Log.d("GenexSDK", feedbackAnglesTable.toString())
          } catch (e: Exception) {
              Log.e("genex_android_feedback", e.printStackTrace().toString())
          }
      }

     
      private func getFeedback(
          poseSeq: PoseSequence,
          exName: String,
          side: String,
          keypoint: String
      ) -> Utils.CustomFeedbackClass {

  //        Make angles from pose sequence
          var ps = getJointIndexes(keypoint.toInt(), side)
          var angles = getJointAngles(poseSeq, ps)

  //        Initialize ideal min and max angles for the given setup
          var minIdealAngle =
              feedbackAnglesTable[mutableListOf(exName, side, keypoint, "min")]?.get(0)?.toFloat()
                  
          var maxIdealAngle =
              feedbackAnglesTable[mutableListOf(exName, side, keypoint, "max")]?.get(0)?.toFloat()

  //        Find min and max angles from the given pose sequence
          var minAngle = angles.minOrNull()
          var maxAngle = angles.maxOrNull()

  //        Logic for giving feedback
          if (minAngle < (minIdealAngle - Constants.FEEDBACK_EASINESS)) { // D1
              var feedback = feedbackTable[mutableListOf(exName, keypoint, "D1")]
              return Utils.CustomFeedbackClass(
                  feedback?.get(0),
                  feedback?.get(1),
                  isFormDetected = true,
                  isFormCorrect = false
              )
          }
          if (minAngle > (minIdealAngle - Constants.FEEDBACK_EASINESS)) { // D2
              var feedback = feedbackTable[mutableListOf(exName, keypoint, "D2")]
              return Utils.CustomFeedbackClass(
                  feedback?.get(0),
                  feedback?.get(1),
                  isFormDetected = true,
                  isFormCorrect = false
              )
          }
          if (maxAngle < (maxIdealAngle - Constants.FEEDBACK_EASINESS)) { // U1
              var feedback = feedbackTable[mutableListOf(exName, keypoint, "U1")]
              return Utils.CustomFeedbackClass(
                  feedback?.get(0),
                  feedback?.get(1),
                  isFormDetected = true,
                  isFormCorrect = false
              )
          }
          if (maxAngle > (maxIdealAngle - Constants.FEEDBACK_EASINESS)) { // U2
              var feedback = feedbackTable[mutableListOf(exName, keypoint, "U2")]
              return Utils.CustomFeedbackClass(
                feedback?.get(0),
                feedback?.get(1),
                isFormDetected = true,
                isFormCorrect = false
              )
              return Utils.CustomFeedbackClass()
          
          }
}
