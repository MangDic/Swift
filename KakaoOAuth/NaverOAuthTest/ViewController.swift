//
//  ViewController.swift
//  NaverOAuthTest
//
//  Created by 이명직 on 2021/06/11.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

struct getData {
    var nickName: String
    var email: String
    var age: String
}
