public struct Genex_iOS {
    
    
    func getExerciseAnalytics() {
      
        let poseArray = [""]

        let exName: String

        let oldRcLockL: Bool

        let oldRcLockR: Bool
        
        
       Utils.CustomRepClass {
            //        rcLockL = oldRcLockL
            //        rcLockR = oldRcLockR
            
            Log.d("GenexRep", "${poseArray.size} x ${poseArray[0].size} x ${poseArray[0][0].size}")
            return parseObj.countReps(poseArray, exName, oldRcLockL, oldRcLockR)
            
            //        rcLockL = retArray.repCountLockLeft
            //        rcLockR = retArray.repCountLockRight
        }
        //Return energy value for a given estimated pose array
        func getEnergyValue(poseArray: Array<Any>) {
            return 1e5/findEnergyDistane(poseArray)
        }
        //Return feedback for a given estimated pose array
        func getFeedBack() {
            poseArray(arraylist(Array))
        exName: String
        }
        
        return fbObj.giveFeedback(poseArray, exName)
    }
}
