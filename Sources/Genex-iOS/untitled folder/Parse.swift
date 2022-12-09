//
//  File.swift
//  
//
//  Created by Arpit Joseph  on 02/12/22.
//

import Foundation

class Parse {
    
   var repCountAnglesTable = Hashtable()
   var impAnglesTable:; func <MutableList<String>, MutableList<String>> = Hashtable()

       init {
           var homePath = System.getProperty("user.dir")
           println("Working Directory = $homePath")
           Environment.getRootDirectory()

           // Load Rep Count Angles
           var fileName = "Feedback Angles Sheet.csv"
           println("File Name = $fileName")
           try {
   //            val fileReader = BufferedReader(FileReader(fileName))
               val fileReader = context.assets.open(fileName).bufferedReader()

               while (true) {
                   val line = fileReader.readLine() ?: break
                   val tokens = line.split(",")
                   repCountAnglesTable[mutableListOf(tokens[0], tokens[1], tokens[2], tokens[3])] =
                       mutableListOf(tokens[4])
               }
               Log.d("GenexSDK", repCountAnglesTable.toString())
           } catch (e: Exception) {
               Log.e("genex_android_parser", e.printStackTrace().toString())
           }

           // Load Important Angles
           fileName = "Important Angles Sheet.csv"
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
               Log.e("genex_android_parser", e.printStackTrace().toString())
           }
       }
}
