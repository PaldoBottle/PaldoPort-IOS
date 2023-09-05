import Foundation


struct APIConstants {
    
    // MARK: - base URL
    
    static let baseURL = "http://13.125.118.115:8080"
    

    // MARK: - Users
    
    // vv
    static let loginWithKakao = baseURL + "/login/kakao"
    
    // vv
    static let loginWithGoogle = baseURL + "/login/google"
    
    static let logout = baseURL + ""
    
    // v
    static let getUser = baseURL + "/memberinfo"
    
    // MARK: - Challenge
    static let getAchievedChallenge = baseURL + "/challenge/achieve"
    // v
    static let getAllChallengeList = baseURL + "/challenge/list"
    
    // MARK: - Stamp
    
    // vv
    static let getAllStamp = baseURL + "/stamp/user/list"
    
    // v
    static let issueStamp = baseURL + "/stamp/user/new"
    
    
    static let getStampDetail = baseURL + "/stamp"
    
    // MARK: - Region
    
    // 뒤에 추가로 더붙야함
    // vv
    static let getRegion = baseURL + "/region"
    
    // vv
    static let getAllAnnotation = baseURL + "/region/landmark/list"
    
}

