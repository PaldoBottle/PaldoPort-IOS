import Foundation


struct APIConstants {
    
    // MARK: - base URL
    
    static let baseURL = ""
    

    // MARK: - Users
    static let loginWithKakao = baseURL + "/login/kakao"
    
    static let loginWithGoogle = baseURL + "/login/google"
    
    static let logout = baseURL + ""
    static let getUser = baseURL + "/memberinfo"
    
    // MARK: - Challenge
    static let getAchievedChallenge = baseURL + "/challenge/achieve"
    static let getAllChallengeList = baseURL + "/challenge/list"
    
    // MARK: - Stamp
    static let getAllStamp = baseURL + "/stamp/user/list"
    static let issueStamp = baseURL + "/stamp/user/new"
    static let getStampDetail = baseURL + "/stamp"
    
    // MARK: - Region
    
    // 뒤에 추가로 더붙야함
    static let getRegion = baseURL + "/region"
    static let getAllAnnotation = baseURL + "/region/landmark/list"
    
}

