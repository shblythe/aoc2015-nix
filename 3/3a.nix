let
    inherit (builtins)
        head
        length
        readFile
        tail
        ;
    inherit (import ../utils.nix)
        evenListItems
        oddListItems
        stringCharList
        unique
        ;

    move = pos: inst: {
        x = if inst == "<" then pos.x - 1 else if inst == ">" then pos.x + 1 else pos.x;
        y = if inst == "^" then pos.y - 1 else if inst == "v" then pos.y + 1 else pos.y;
    };

    _doMoves = outPosList: pos: moves:
        let newPos = move pos (head moves);
        in
            if moves == [] then outPosList
            else _doMoves (outPosList ++ [newPos]) newPos (tail moves);
    doMoves = pos: moves: _doMoves [pos] pos moves;

    input = readFile ./input.txt;
    pos = {x=0; y=0;};
    moves = stringCharList input;
    list = doMoves pos moves;
    output1 = length (unique (doMoves pos moves));

    santaMoves = oddListItems moves;
    botMoves = evenListItems moves;
    output2 = length (unique ((doMoves pos santaMoves) ++ (doMoves pos botMoves)));
in {
    inherit output1 output2;
}