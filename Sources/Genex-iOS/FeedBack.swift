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

    
    init {
        val homePath = System.getProperty("user.dir")
        println("Working Directory = $homePath")
        
        // Load Important Angles
        var fileName = "Important Angles Sheet.csv"
        println("File Name = $fileName")
        try {
            //            val fileReader = BufferedReader(FileReader("$homePath/$fileName"))
            val fileReader = context.assets.open(fileName).bufferedReader()
            
            while (true) {
                val line = fileReader.readLine() ?: break
                val tokens = line.split(",")
                impAnglesTable[mutableListOf(tokens[0])] = mutableListOf(tokens[1])
            }
            Log.d("GenexSDK", impAnglesTable.toString())
        } catch (e: Exception) {
            Log.e("genex_android_feedback", e.printStackTrace().toString())
        }
        
    }
    // Load Feedback
          fileName = "Feedback Sheet.csv"
          println("File Name = $fileName")
          try {
  //            val fileReader = BufferedReader(FileReader("$homePath/$fileName"))
              val fileReader = context.assets.open(fileName).bufferedReader()

              while (true) {
                  val line = fileReader.readLine() ?: break
                  val tokens = line.split(",")
                  feedbackTable[mutableListOf(tokens[0], tokens[1], tokens[2])] =
                      mutableListOf(tokens[3], tokens[4])
              }
              Log.d("GenexSDK", feedbackTable.toString())
          } catch (e: Exception) {
              Log.e("genex_android_feedback", e.printStackTrace().toString())
          }

          // Load Feedback Angles
          fileName = "Feedback Angles Sheet.csv"
          println("File Name = $fileName")
          try {
  //            val fileReader = BufferedReader(FileReader("$homePath/$fileName"))
              val fileReader = context.assets.open(fileName).bufferedReader()

              while (true) {
                  val line = fileReader.readLine() ?: break
                  val tokens = line.split(",")
                  feedbackAnglesTable[mutableListOf(tokens[0], tokens[1], tokens[2], tokens[3])] =
                      mutableListOf(tokens[4])
              }
              Log.d("GenexSDK", feedbackAnglesTable.toString())
          } catch (e: Exception) {
              Log.e("genex_android_feedback", e.printStackTrace().toString())
          }
      }

      /**
       * Helper function that returns feedback for a particular exercise, side and pose sequence
       * */
      private fun getFeedback(
          poseSeq: PoseSequence,
          exName: String,
          side: String,
          keypoint: String
      ): Utils.CustomFeedbackClass {

  //        Make angles from pose sequence
          val ps = getJointIndexes(keypoint.toInt(), side)
          val angles = getJointAngles(poseSeq, ps)

  //        Initialize ideal min and max angles for the given setup
          val minIdealAngle =
              feedbackAnglesTable[mutableListOf(exName, side, keypoint, "min")]?.get(0)?.toFloat()
                  ?: 180.0f
          val maxIdealAngle =
              feedbackAnglesTable[mutableListOf(exName, side, keypoint, "max")]?.get(0)?.toFloat()
                  ?: 0.0f

  //        Find min and max angles from the given pose sequence
          val minAngle = angles.minOrNull() ?: minIdealAngle
          val maxAngle = angles.maxOrNull() ?: maxIdealAngle

  //        Logic for giving feedback
          if (minAngle < (minIdealAngle - Constants.FEEDBACK_EASINESS)) { // D1
              val feedback = feedbackTable[mutableListOf(exName, keypoint, "D1")]
              return Utils.CustomFeedbackClass(
                  feedback?.get(0) ?: "No Feedback",
                  feedback?.get(1) ?: "0.mp3",
                  isFormDetected = true,
                  isFormCorrect = false
              )
          }
          if (minAngle > (minIdealAngle - Constants.FEEDBACK_EASINESS)) { // D2
              val feedback = feedbackTable[mutableListOf(exName, keypoint, "D2")]
              return Utils.CustomFeedbackClass(
                  feedback?.get(0) ?: "No Feedback",
                  feedback?.get(1) ?: "0.mp3",
                  isFormDetected = true,
                  isFormCorrect = false
              )
          }
          if (maxAngle < (maxIdealAngle - Constants.FEEDBACK_EASINESS)) { // U1
              val feedback = feedbackTable[mutableListOf(exName, keypoint, "U1")]
              return Utils.CustomFeedbackClass(
                  feedback?.get(0) ?: "No Feedback",
                  feedback?.get(1) ?: "0.mp3",
                  isFormDetected = true,
                  isFormCorrect = false
              )
          }
          if (maxAngle > (maxIdealAngle - Constants.FEEDBACK_EASINESS)) { // U2
              val feedback = feedbackTable[mutableListOf(exName, keypoint, "U2")]
              return Utils.CustomFeedbackClass(
                feedback?.get(0) ?: "No Feedback",
                feedback?.get(1) ?: "0.mp3",
                isFormDetected = true,
                isFormCorrect = false
              )
              return Utils.CustomFeedbackClass()
          
          }
}
