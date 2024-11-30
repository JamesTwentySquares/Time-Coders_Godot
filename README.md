Day 3 
Currently have implemented: Character controller with walking, running and jumping, imported char model, added blend anim tree with idle, walk and run. This took some time as there was small issue with the blend tree innitially as well as refining character rotation.

Day 5 > final commit
Spent a large amount of time trying to make the coin collection update a UI element
Did some Polish > level ddesign 
Tweaked character controller for smoother operation

Instructions:
Player is trying to escape the level > has to pay their way to freedom by finding coins in the level.
Controls: WASD
Jump: Space
Run: Hold Shift 

Controller:
nice, quite smooth - public var in the inspector to adjust to preferences of acceleate, jump height etc.

Features:
Char controller
Char anims: Idle, Run, Jump
Basic level layout + Grid editor
Collect Coins
Unlock Door (not working)

Unfinished:
Camera controller (stopped dev due to time constraints but wanted to have it that the player could use camera rotation and tilt to help navigate levels)
Did not manage to finish puzzle idea > was trying to make it that when player collects all the coins in the level the Gate would be "unlocked/dissapear"
Main issue was connecting the Game Manager Signal with the Gate correctly? Could even be a pathing issue in the hierachy of the scene.

Challenges:
Learning how the Signal system works in Godot, getting scnes to talk to each other I faced this issue both with my update coin UI feature i tried as well as the gate destroy mechanic.
I tried addressing the issue by changing how the signals were sent, checking hierachy structure, making sure the signal is being sent/ listened to.

Thank you for the challenge and the opportunity to submit something! 
