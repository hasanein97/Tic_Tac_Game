import 'package:flutter/material.dart';
import 'package:tic_tac/game_logic.dart';
import 'game_logic.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = "x";
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child:MediaQuery.of(context).orientation == Orientation.portrait? Column(
          children: [
            ...firstBlock(),
            _expanded(context),
           ... lastBlock(),
          ],
        ):Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ...firstBlock(),
                const SizedBox(
                  height:20,
                ),
                ... lastBlock(),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<Widget>firstBlock(){
return [
  SwitchListTile.adaptive(
    title: const Text(
      'Turn on/off two player',
      style: TextStyle(
        fontSize: 28,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    value: isSwitched,
    onChanged: (bool newValue) {
      setState(() {
        isSwitched = newValue;
      });
    },
  ),
  Text(
    "It's $activePlayer turn".toUpperCase(),
    style: const TextStyle(
      fontSize: 52,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  ),
];
  }
  List<Widget>lastBlock(){
   return [
     Text(
       result,
       style: const TextStyle(
         fontSize: 42,
         color: Colors.white,
       ),
       textAlign: TextAlign.center,
     ),
     ElevatedButton.icon(
       onPressed: () {
         setState(() {
           player.playerX = [];
           player.playerO = [];
           activePlayer = "x";
           gameOver = false;
           turn = 0;
           result = '';
         });
       },
       icon: const Icon(Icons.replay),
       label: const Text('Repeat the game'),
       style: ButtonStyle(
         backgroundColor: MaterialStateProperty.all(
           Theme.of(context).splashColor,
         ),
       ),
     ),
   ];
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1,
              crossAxisCount: 3,
              children: List.generate(
                9,
                (index) => InkWell(
                  borderRadius:  BorderRadius.circular(16),
                  onTap: gameOver? null:() => _onTab(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child:  Text(
                        player.playerX.contains(index)?
                        'x'
                        :player.playerO.contains(index)
                        ?'o'
                       :'',
                        style:  TextStyle(
                          color: player.playerX.contains(index)
                          ?Colors.blue
                          :Colors.pink,
                          fontSize: 52,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  _onTab(int index)async {

    if (player.playerX.isEmpty||
        ! player.playerX.contains(index)&&
            ( player.playerO.isEmpty||
     !player.playerO.contains(index)))
    {
    game.playGame(index,activePlayer);
    updateState();
    if(!isSwitched && !gameOver && turn != 9){
       await game.autoPlay (activePlayer);
       updateState();
    }
    }
  }
  void updateState(){
    setState(() {
      activePlayer = (activePlayer == 'x')? 'o':'x';
      turn++;
     String winnerPlayer = game.checkWinner() as String;
     if(winnerPlayer !=''){
       gameOver = true;
       result ='$winnerPlayer is the winner';}
     else if (!gameOver && turn ==9){
       result ='It\'s Draw!';
     }
    });
  }
}
