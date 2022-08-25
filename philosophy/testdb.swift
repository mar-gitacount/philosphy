//
//  testdb.swift
//  philosophy
//
//  Created by 市川マサル on 2022/08/26.
//

import SwiftUI
import FirebaseDatabase

struct testdb: View {
    @State var message = ""
    
    var body: some View {
        VStack {
            Text(message)
                .padding()
        }.onAppear {
            let ref = Database.database().reference()
            ref.child("message").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    guard let message = snapshot.value as? String else {
                        return
                    }
                    self.message = message
                }
                else {
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
