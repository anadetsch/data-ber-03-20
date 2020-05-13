## Challenge 1
One player rolls two dices. Describe the measurable space and the random variable for:

### 1 - A. The values that the player obtains.
Measurable Space - All the 36 possible combinations. {(1,1),(1,2),(1,3),(1,4),(1,5),...,(6,6)}

Random Variable - The combination that came out

### 1 - B. The sum of the values obtained.
Measurable Space - All the 36 possible combinations.

Random Variable - Sum of both dice values. e.g.: (1,5) = 6

### 1 - C. The maximum value obtained after rolling both dices.
Measurable Space - All the 36 possible combinations.

Random Variable - The highest possible combination. Or a "normal" die would be (6,6) = 12

### Case A: Both values are greater than 5.
`Only happens if both dices are 6 (6,6)`

### Case B: The sum of values is even.
`{(1,1),(1,3),(1,5),(2,2),(2,4),(2,6),(3,1),(3,3),(3,5),(4,2),(4,4),(4,6),(5,1),(5,3),(5,5),(6,2),(6,4),(6,6)}`

### Case C: The maximum is the value of both rolls.
The same number on both dices.

## Challenge 2
One player picks two cards from a poker deck. Describe the measurable space and the random variable for:

### A. The number of figures he picks.
Measurable Space - The Full deck

Random Variable - Can be 0, 1 or 2 figures

### B. The sum of card values. Consider that the value of figures is 10 and the value of aces is 15.
Measurable Space - The Full deck

Random Variable - Can be any value between 4 and 30. e.g.:(2,2) = 4; (A,A) = 15

### C. The number of hearts or spades he picks.

Measurable Space - The Full deck

Random Variable - Can be 0, 1 or 2

### Case A: The number of figures in the cards the player picked is two.
`There are 9 combinations possible: {(K,K),(K,Q),(K,J),(Q,Q),(Q,K),(Q,J),(J,J),(J,K),(J,Q)}`

### Case B: The sum of card values is 17.
`Possible Combinations: {(A,2),(K,7),(J,7),(Q,7),(10,7),(9,8),(2,A),(7,K),(7,J),(7,Q),(7,10),(8,9)}`

### Case C: The value of both cards is less than 8.
`Can only be a combination of cards with a number lower than 8: {(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),..,(7,2),(7,3),(7,4),(7,5),(7,6),(7,6)}
`
## Challenge 3
Two players roll a dice. Describe the measurable space and the random variable for:

### A. The score of player A.
Measurable Space - Any Value between 2 and 12

Random Variable - The score A

### B. The greatest score.
Measurable Space - Any Value between 2 and 12

Random Variable - Score A and Score B

### C. The earnings of player A if the game rules state that:
#### "The player with the greatest score gets a coin from the other player.".

Measurable space - Any Value between 2 and 12

Random Variable - Win (+1) or Lose (-1)

### D. The earnings of player A if the game rules state that:
#### "The player with the greatest score gets as many coins as the difference between the score of player A and player B.".

Measurable space - Any Value between 2 and 12

Random Variable - Can be any value between 0 and 5

### Case A: The score of player A is 2.
`{(2,1),(2,2),(2,3),(2,4),(2,5),(2,6)}`
### Case B: The greatest score is lower or equal than 2.
`{(1,1),(2,1),(2,2),(1,2)}`
### Case C: Considering the case where the winner gets as many coins as the difference between scores (D), describe:
#### Player A wins at least 4 coins.

`Score A >= Score B +4: {(5,1),(6,1),(6,2)}`

#### Player A loses more than 2 coins.

`Score A < Score B -2 : {(1,4),(1,5),(1,6),(2,5),(2,6),(3,6)}`

#### Player A neither wins nor loses coins.
`Score A = Score B : {(1,1),(2,2),(3,3),(4,4),(5,5),(6,6)}`
