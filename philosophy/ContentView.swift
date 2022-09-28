//
//  ContentView.swift
//  philosophy
//
//  Created by 市川マサル on 2022/08/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

struct ContentView: View {
    @State private var email: String = ""
    @State private var email_error: String = ""
    @State private var password: String = ""
    @State private var password_error: String = ""
    @State private var alertMessage:String = ""
    @State private var isShowAlert = false
    @State private var name = ""
    @State private var message = ""
    @State private var editting = false
    @State private var email_edittiig = false
    @State private var password_editting = false
    //アップル認証のコード。
    @State private var signInWithAppleObject = SignInWithAppleObject()
    var body: some View {
        VStack {
            //入力文字大文字を設定しない。
            Text(email_error).foregroundColor(Color.red)
            TextField("E-mail", text: self.$email,onEditingChanged: {
                begin in
                /// 入力開始処理
                //isMarried ? print("既婚者です。") : print("独身です。")
                if begin {
                    self.email_edittiig = true    // 編集フラグをオン
                    self.email = ""       // メッセージをクリア
                /// 入力終了処理
                } else {
                    self.email_edittiig = false   // 編集フラグをオフ
                }
            }).autocapitalization(.none).textFieldStyle(RoundedBorderTextFieldStyle()) // 入力域を枠で囲む
                .padding()// 余白を追加
                // 編集フラグがONの時に枠に影を付ける
                .shadow(color: email_edittiig ? .blue : .clear, radius: 3)
            Text(password_error).foregroundColor(Color.red)
            TextField("Password", text: self.$password,onEditingChanged: { begin in
                /// 入力開始処理
                if begin {
                    self.password_editting = true    // 編集フラグをオン
                    self.password = ""       // メッセージをクリア
                /// 入力終了処理
                } else {
                    self.password_editting = false   // 編集フラグをオフ
                }
            }).keyboardType(.default).autocapitalization(.none).textFieldStyle(RoundedBorderTextFieldStyle()).padding() .shadow(color: password_editting ? .blue : .clear, radius: 3)
            //ログイン方法はアップルログインと、通常のログインを実装する。
            //falseが帰ってきた場合、登録画面にリダイレクトする。
            //入力値を制御す
            Button(action: {
                self.email_error = ""
                self.password_error = ""
                if(self.email == ""){
                //ここでfalseを返す
                    self.email_error = "メールアドレスを入力してください。"
                }else if(self.password == ""){
                    self.password_error = "パスワードを入力してください。 "
                }else{
                    //ここでサインイン設定。trueなら画面遷移して、会員のページにいく。
                    Auth.auth().signIn(withEmail:email,password: password) { (resurt,error) in
                       //認証で何かしらのエラーで実行される条件
                       if error != nil{
                          //エラーコードの変数を設定する。
                          //ここで登録画面打診メッセージを表示する。
                         self.email_error = "登録がありません"
                          //let errorCode = AuthErrorCode(rawValue: error.code)
                          //self.alertMessage = error?.localizedDescription ?? ""
                          self.alertMessage = "Error"
                          self.isShowAlert = true
                        
                        }else{
                            //認証が成功した時の処理を書く
                            //ログイン成功したら、それにひもづくデータを返す
                            //会員ページに画面遷移する。
                            //self.email_error = user.email
                            let user = Auth.auth().currentUser
                            let ref = Database.database().reference()
//                            let alovelaceDocumentRef = ref.child("users").child("1AzjIctS3DOvIZHOHkmmfcCIXGi1").child(name)
                            
                            //1AzjIctS3DOvIZHOHkmmfcCIXGi1
                            //成功したら画面を遷移してユーザーページを表示する。
                            if let user = user {
                                let uids = user.uid
                                let email = user.email
                                let db = Firestore.firestore()
                                //firestoreでuserコレクション内のドキュメントを取得する。
                                let userget = db.collection("users").document("1AzjIctS3DOvIZHOHkmmfcCIXGi1")
                                    userget.getDocument { (document,error) in
                                        if let document = document, document.exists{
                                            let dataDesciption = document.data().map(String.init(describing:)) ?? "nil"
                                            self.email_error = "あるよ"
                                        } else {
                                            self.email_error = "ないよ"
                                        }
                                    }
                               // self.email_error = self.email
                            }
                            //ここで画面を遷移する。
                            self.alertMessage = "Success"
                            self.isShowAlert = true
                        }
                    }
                }
            }, label: {
                Text("フィロソフィア会員はこちら").font(.body).frame(width:350,height: 50).background(Color.black)
                //isPresented=他の画面から呼ばれた場合の処理。
            })//.alert(isPresented: $isShowAlert, content:{Alert(title: Text($alertMessage))}).padding().cornerRadius(60)
              .accentColor(Color.white)
                   Button(action: {
                       signInWithAppleObject.signInWithApple()
                   }, label: {
                       SignInWithAppleButton()
                           .frame(height: 50)
                           .cornerRadius(16)
                   })
                   .padding()
               }
    }
    func editing_func(begin: Bool) -> Bool{
        if(begin){
            return true
        }else{
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




