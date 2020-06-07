//
//  GameData.swift
//  TicTacToe
//
//  Created by Jacob Su on 6/6/20.
//  Copyright © 2020 Jacob Su. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class TicTacToeViewModel: ObservableObject {
    @Published var gameTitle: String = ""
    
    @Published var isNextX: Bool = true
    
    @Published var isWinnerX: Bool? = nil
    
    @Published var tics: Array<Bool?> = Array<Bool?>(repeating: nil, count: 9)
    
    private let allWins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        $isNextX.map {
            if (self.isWinnerX == true) {
                return "The Winner is X"
            } else if (self.isWinnerX == false) {
                return "The Winner is O"
            }
            
            if ($0) {
                return "Next Player X"
            } else {
                return "Next Player O"
            }
        }.assign(to: \.gameTitle, on: self)
        .store(in: &subscribers)
        
        $tics.map { tics in
            let win = self.allWins.first(where: { w in
                let a = w[0]
                let b = w[1]
                let c = w[2]
                
                return tics[a] != nil && tics[a] == tics[b] && tics[b] == tics[c]
            })
            
            guard let w = win else {
                return nil
            }
            
            return tics[w[0]]
        }.assign(to: \.isWinnerX, on: self)
            .store(in: &subscribers)
    }
    
    func getTic(row: Int, column: Int) -> String {
        
        guard row < 3 && column < 3 else {
            return " "
        }
        
        switch tics[row * 3 + column] {
        case nil:
            return " "
        case false:
            return "O"
        default:
            return "X"
        }
    }
    
    func reset() {
        (0 ..< 9).forEach {
            tics[$0] = nil
        }
    }
    
    private func updateGameTitle() {
        if (isNextX) {
            gameTitle = "Next Player X"
        } else {
            gameTitle = "Next Player O"
        }
    }
}
