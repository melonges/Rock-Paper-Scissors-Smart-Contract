// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


contract TicTacToe {
   function isSolved(int[3][] memory board ) public pure returns (int) {
    int has_zero = 0;
    
    if (board[0][0] != 0 && board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
     return board[0][0];
    }
    
      for (uint i = 0; i < board.length; i++) {
        if (board[i][0] == 0 || board[i][1] == 0 || board[i][2] == 0) {
          has_zero = 1;
        }
        
          if (board[0][0] != 0 && board[i][0] == board[i][1] && board[i][0] == board[i][2]) {
              return board[i][0];

          }

          if (board[0][0] != 0 && board[0][i] == board[1][i] && board[0][i] == board[2][i]) {
            return board[0][i];
          }
      }
    
    return ~has_zero + 1;
  }
}
