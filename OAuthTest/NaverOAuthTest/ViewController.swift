//
//  ViewController.swift
//  NaverOAuthTest
//
//  Created by 이명직 on 2021/06/11.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire

class ViewController: UIViewController {
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInstance?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    fileprivate func moveNextVC() {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "ShowUserDataViewController") else {
            return
        }
        VC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        present(VC, animated: true, completion: nil)
    }
    
    
    
    fileprivate func getUserDataWithKakao() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print("me() error")
            }
            else {
                if let user = user {
                    
                    //필요한 scope을 아래의 예제코드를 참고해서 추가한다.
                    //아래 예제는 모든 스콥을 나열한것.
                    var scopes = [String]()
                
                    
                    print("가져온 정보 !")
                    print(user.kakaoAccount?.ageRange)
                    print(type(of: user.kakaoAccount?.ageRange?.rawValue))
                    print(KakaoSDKUser.AgeRange.self)
                    
                    ShowUserDataViewController.user.nickName = (user.properties!["nickname"] as? String) ?? "Null"
                    ShowUserDataViewController.user.age = user.kakaoAccount?.ageRange as? String ?? "Null"
                    ShowUserDataViewController.user.email = user.kakaoAccount?.email ?? "Null"
                    ShowUserDataViewController.type = "Kakao"
//                    if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
//                    if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
//                    if (user.kakaoAccount?.birthdayNeedsAgreement == true) { scopes.append("birthday") }
//                    if (user.kakaoAccount?.birthyearNeedsAgreement == true) { scopes.append("birthyear") }
//                    if (user.kakaoAccount?.genderNeedsAgreement == true) { scopes.append("gender") }
//                    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) { scopes.append("phone_number") }
//                    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) { scopes.append("age_range") }
//                    if (user.kakaoAccount?.ciNeedsAgreement == true) { scopes.append("account_ci") }
                    
                    self.moveNextVC()
                    print(scopes)
                    
                    if scopes.count == 0  { return }
                    
                    //필요한 scope으로 토큰갱신을 한다.
                    UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            UserApi.shared.me() { (user, error) in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    print("me() success.")
                                    
                                    //do something
                                    _ = user
                                }
                                
                            } //UserApi.shared.me()
                        }
                        
                    } //UserApi.shared.loginWithKakaoAccount(scopes:)
                }
                
            }
        }
    }
    @IBAction func didTabNaver(_ sender: Any) {
        loginInstance?.requestThirdPartyLogin()
    }
    
    
    @IBAction func didTabKaKao(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoAccount() {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print("Login error")
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                    // 어세스토큰
                    let accessToken = oauthToken?.accessToken
                    self.getUserDataWithKakao()
                }
            }
        }
    }
}

extension ViewController: NaverThirdPartyLoginConnectionDelegate {
    func naverDataFetch(){
        guard let naverConnection = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        guard let accessToken = naverConnection.accessToken else { return }
        let authorization = "Bearer \(accessToken)"

        if let url = URL(string: "https://openapi.naver.com/v1/nid/me") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(authorization, forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }

                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                    guard let response = json["response"] as? [String: AnyObject] else { return }
                    let id = response["id"] as? String
                    let email = response["email"] as? String
                    let name = response["name"] as? String
                    let nickname = response["nickname"] as? String
                    let profileImage = response["profile_image"] as? String
                    let birthday = response["birthday"] as? String
                    let gender = response["gender"] as? String
                    print("id: \(id)")
                    print("email: \(email)")
                    print("name: \(name)")
                    print("nickname: \(nickname)")
                    print("profileImage: \(profileImage)")
                    print("birthday: \(birthday)")
                    print("gender: \(gender)")
                    ShowUserDataViewController.user.nickName = nickname ?? "Null"
                    ShowUserDataViewController.user.age = birthday ?? "Null"
                    ShowUserDataViewController.user.email = email ?? "Null"
                    ShowUserDataViewController.type = "Naver"
                    
                    DispatchQueue.main.async {
                        self.moveNextVC()
                    }
                } catch let error as NSError {
                    print(error)
                }
                }.resume()
        }
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        // 로그인 성공 (로그인된 상태에서 requestThirdPartyLogin()를 호출하면 이 메서드는 불리지 않는다.)
        self.naverDataFetch()
    }
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        // 로그인된 상태(로그아웃이나 연동해제 하지않은 상태)에서 로그인 재시도
        self.naverDataFetch()
    }

    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        //  접근 토큰, 갱신 토큰, 연동 해제등이 실패
    }
    

    func oauth20ConnectionDidFinishDeleteToken() {
        // 연동해제 콜백

    }
//
//    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
//        self.present(NLoginThirdPartyOAuth20InAppBrowserViewController(request: request), animated: true, completion: nil)
//    }
}

struct getData {
    var nickName: String
    var email: String
    var age: String
}
