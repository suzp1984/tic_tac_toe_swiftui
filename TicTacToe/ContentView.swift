//
//  ContentView.swift
//  TicTacToe
//
//  Created by Jacob Su on 6/6/20.
//  Copyright © 2020 Jacob Su. All rights reserved.
//

import SwiftUI

struct TicTacGameView: View {
    var body: some View {
        VStack(spacing: -2.0) {
            ForEach(0 ..< 3) { item in
                HStack(spacing: -2.0) {
                    ForEach(0 ..< 3) { item in
                        Button(action: {
                            
                        }) {
                            Text("X")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                        }
                        .frame(width: 50.0, height: 50.0)
                        .border(Color.gray, width: 2)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacGameView()
    }
}
