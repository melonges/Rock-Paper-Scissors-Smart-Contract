// SPDX-License-Identifier: BSD-2-Clause
pragma solidity ^0.8.0;

contract RockPaperScissors {
  event GameCreated(address creator, uint gameNumber, uint bet);
  event GameStarted(address[] players, uint gameNumber);
  event GameComplete(address winner, uint gameNumber);
  uint gameCounter = 0;
  
  mapping(uint => Game) public rooms;
  
  enum StatusGame {
    None,
    Rock,
    Paper,
    Scissors,
  }
  struct Game {
    address[2] players;
    uint bet;
    bool participantConnected;
    StatusGame[2] status;
   
  }
  
  /**
   * Use this endpoint to create a game. 
   * It is a payable endpoint meaning the creator of the game will send ether directly to it.
   * The ether sent to the contract should be used as the bet for the game.
   * @param {address} participant - The address of the participant allowed to join the game.
   */
  function createGame(address payable participant) public payable {
    rooms[gameCounter] = Game([msg.sender, participant], msg.value, false, [None, None]);
    gameCounter++;
  }
  
  /**
   * Use this endpoint to join a game.
   * It is a payable endpoint meaning the joining participant will send ether directly to it.
   * The ether sent to the contract should be used as the bet for the game. 
   * Any additional ether that exceeds the original bet of the creator should be refunded.
   * @param {uint} gameNumber - Corresponds to the gameNumber provided by the GameCreated event
   */
  function joinGame(uint gameNumber) public payable {
    rooms[gameNumber].participantConnected = true;
  }
  
  /**
   * Use this endpoint to make a move during a game 
   * @param {uint} gameNumber - Corresponds to the gameNumber provided by the GameCreated event
   * @param {uint} moveNumber - The move for this player (1, 2, or 3 for rock, paper, scissors respectively)
   */
  function makeMove(uint gameNumber, uint moveNumber) public {
    mapping(uint => Game) room = rooms[gameNumber];
    address winner;
    if (msg.sender == room.players[0]) {
      room.status[0] = StatusGame(moveNumber);
    } else {
      room.status[1] = StatusGame(moveNumber)
    }
    if (room.status[0] != StatusGame.None && room.status[1] != StatusGame.None) {
      if (room.status[0] == room.status[1]) {
        // бабки в общагw
      }
      
      if (room.status[0] == StatusGame.Rock && room.status[1] == StatusGame.Scissors 
          || room.status[0] == StatusGame.Paper && room.status[1] == StatusGame.Rock
          || room.status[0] == StatusGame.Scissors && room.status[1] == StatusGame.Paper
         ) {
        winner = room.players[0];
      } else {
         winner = room.players[1];
      }
    }
  }
}
