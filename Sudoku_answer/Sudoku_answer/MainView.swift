//
//  MainView.swift
//  Sudoku_answer
//
//  Created by 최시훈 on 1/1/24.
//

import SwiftUI

struct MainView: View {
    let firstSudokuBoard: [[Int]] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    @State private var sudokuBoard: [[Int]] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            ForEach(0..<9) { row in
                HStack {
                    ForEach(0..<9) { col in
                        TextField("", text: Binding(
                            get: { "\(sudokuBoard[row][col])" },
                            set: { newValue in
                                if let number = Int(newValue) {
                                    sudokuBoard[row][col] = min(max(number, 0), 9)
                                }
                            }
                        ))
                        .frame(width: 30, height: 30, alignment: .center)
                        .border(Color.black)
                        .foregroundColor(sudokuBoard[row][col] == 0 ? .blue : .black)
                        .font(.headline)
                        if col % 3 == 2 && col != 8 {
                            Divider()
                                .frame(width: 3,height: 30)
                            
                                .background(Color.black)
                        }
                    }
                    
                }
                if row % 3 == 2 && row != 8 {
                    Divider()
                        .frame(height: 3)
                        .background(Color.black)
                    
                }
            }
            
            Button("풀기") {
                solveSudoku()
                
            }
            .alert("풀이 실패🚫", isPresented: $showingAlert) {
                Button("확인") {}
            } message: {
                Text("스도쿠 풀이에 실패하였습니다. \n 문제를 다시 한 번 확인해 주세요")
            }

            Button("리셋") {
                sudokuBoard = firstSudokuBoard
            }
        }
        .padding()
    }
}


    extension MainView {
    private func solveSudoku() {
        if solveSudokuHelper(&sudokuBoard) {
            print("성공!")
        } else {
            showingAlert = true
        }
    }
    
    private func solveSudokuHelper(_ board: inout [[Int]]) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == 0 {
                    for num in 1...9 {
                        if isValid(board: board, row: i, col: j, num: num) {
                            board[i][j] = num
                            if solveSudokuHelper(&board) {
                                return true
                            }
                            board[i][j] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    private func isValid(board: [[Int]], row: Int, col: Int, num: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }
        
        let startRow = row - row % 3
        let startCol = col - col % 3
        for i in 0..<3 {
            for j in 0..<3 {
                if board[startRow + i][startCol + j] == num {
                    return false
                }
            }
        }
        
        return true
    }
}

#Preview {
    MainView()
}

