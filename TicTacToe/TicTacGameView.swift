//
//  ContentView.swift
//  TicTacToe
//
//  Created by Jacob Su on 6/6/20.
//  Copyright © 2020 Jacob Su. All rights reserved.
//

import SwiftUI

struct TicTacGameView: View {
    @EnvironmentObject private var ticTacToeViewModel: TicTacToeViewModel
    
    var body: some View {
        VStack {
            Text(ticTacToeViewModel.gameTitle)
                .padding(.bottom, 10.0)
            
            VStack(spacing: -2.0) {
                ForEach(0 ..< 3) { row in
                    HStack(spacing: -2.0) {
                        ForEach(0 ..< 3) { column in
                            Button(action: {
                                self.handleClick(row: row, column: column)
                            }) {
                                            
                                Text(self.ticTacToeViewModel.getTic(row: row, column: column))
                                    .font(.system(size: 80))
                                    .fontWeight(.bold)

                                
                            }
                            .frame(width: 100.0, height: 100.0)
                            .border(Color.gray, width: 2)
                        }
                    }
                }
            }
            
            Button(action: {
                self.ticTacToeViewModel.reset()
            }) {
                Text("Reset").font(.title).fontWeight(.medium)
            }.padding(.top, 20)
                .disabled(self.ticTacToeViewModel.isResetDisabled)
        }
    }
    
    func handleClick(row: Int, column: Int) {
        guard ticTacToeViewModel.isWinnerX == nil else {
            return
        }
        
        guard (row * 3 + column) < 9 else {
            return
        }
        
        guard ticTacToeViewModel.tics[row * 3 + column] == nil else {
            return
        }
        
        ticTacToeViewModel.tics[row * 3 + column] = ticTacToeViewModel.isNextX
        
        ticTacToeViewModel.isNextX.toggle()
    }

}

struct TicTacGameView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacGameView()
        .environmentObject(TicTacToeViewModel())
    }
}
