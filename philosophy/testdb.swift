//
//  testdb.swift
//  philosophy
//
//  Created by 市川マサル on 2022/08/26.
//

import SwiftUI
import FirebaseDatabase


//ナビゲーションバーを表示するときに使う。
//struct page: View {
//    var body: some View{
//        NavigationLink(destination:ContentView()){
//            Text("ログイン画面")
//        }.padding()
//    }
//}


struct testdb: View {
    @State var message = ""
    var body: some View {
        VStack {
            Text(message)
                .padding()
        //onAppearはviewが表示された時に呼び出されるアクション
        //selfはそれ自体という意味。self変数=値とすれば、その変数の値が変わる。
        }.onAppear {
           // var ref: DatabaseReference!
            //データベースのインスタンス作成。
            let ref = Database.database().reference()
            //ref = Database.database().reference()
            //messageをダブルクｫーテーションで囲むとなぜかクラッシュする。
            //データベースにネストされた子ノードのmeesageデータを読み込む
            ref.child("message").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                    self.message = "test"
                }
                //notnillを抜けることによって、エラーを防ぐ。
                else if let snapshot = snapshot {
                    if snapshot.exists(){
                        guard let message = snapshot.value as? String else {
                            self.message = "test"
                            return
                        }
                        self.message = message
                    }
                }
                else {
                    self.message = "test"
                    print("No data available")
                }
            }
        }
    }
}

struct testdb_Previews: PreviewProvider {
    static var previews: some View {
        testdb()
    }
}


//if let error = error {
//
//} else if let snapshot = snapshot {
//    if snapshot.exists() {
//        ...
//}
