//
//  ContentView.swift
//  TestCode
//
//  Created by 양호준 on 2024/02/26.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationSplitView {
            Text("테스트 코드 강의")
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
}
