import 'dart:math';
class player {
  static const x = "x";
  static const o = "o";
  static const empty = '';
  static List<int> playerX = [];
  static List<int> playerO = [];
}
extension ContainsAll on List {
 bool containsAll(int x, int y, [z]){
   if (z == null )
     return contains(x) && contains(y);
   else
   return contains(x) && contains(y)&& contains(z);
  }
}
class Game{
  void playGame(int index, String activePlayer) {
if(activePlayer =="x")
  player.playerX.add(index);
else
  player.playerO.add(index);
  }
  checkWinner(){
    String winner = '';
    if (player.playerX.containsAll(0,1,2) ||
   player.playerX.containsAll(3,4,5) ||
   player.playerX.containsAll(6,7,8) ||
   player.playerX.containsAll(0,3,6) ||
   player.playerX.containsAll(1,4,7) ||
   player.playerX.containsAll(2,5,8) ||
   player.playerX.containsAll(1,4,8) ||
   player.playerX.containsAll(2,4,6))
      winner ='x';
   else if (player.playerX.containsAll(0,1,2) ||
        player.playerX.containsAll(3,4,5) ||
        player.playerX.containsAll(6,7,8) ||
        player.playerX.containsAll(0,3,6) ||
        player.playerX.containsAll(1,4,7) ||
        player.playerX.containsAll(2,5,8) ||
        player.playerX.containsAll(1,4,8) ||
        player.playerX.containsAll(2,4,6))
      winner = 'O';
else
  winner = '';
    return winner;
  }
   Future <void> autoPlay( activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (var i = 0; i<9; i++){
      if(!(player.playerX.contains(i)|| player.playerO.contains(i)))
      emptyCells.add(i);
    }
    if(player.playerX.containsAll(0,1) && emptyCells.contains(2))
    index = 2;
    else if(player.playerX.containsAll(3,4)  && emptyCells.contains(5))
      index = 2;
    else if(player.playerX.containsAll(6,7)  && emptyCells.contains(8))
      index = 2;
    else if(player.playerX.containsAll(0,3)  && emptyCells.contains(6))
      index = 2;
    else if(player.playerX.containsAll(1,4)  && emptyCells.contains(7))
      index = 2;
    else if(player.playerX.containsAll(2,5)  && emptyCells.contains(8))
      index = 2;
    else if(player.playerX.containsAll(1,4)  && emptyCells.contains(8))
      index = 2;
    else if(player.playerX.containsAll(2,4)  && emptyCells.contains(6))
      index = 2;


    else{
    Random random = Random();
    int randomIndex = random.nextInt(emptyCells.length);
    index = emptyCells[randomIndex];
    }
   playGame(index, activePlayer);
   }
}