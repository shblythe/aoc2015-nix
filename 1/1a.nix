let
    inherit (builtins)
        filter
        foldl'
        head
        isString
        length
        readFile
        split
        stringLength
        tail;
    inherit (import ../utils.nix)
        splitString;
    input = readFile ./input.txt;
    calcFloor = list:
        foldl'
            (x: y:
                x + (
                    if y=="(" then 1
                    else -1)
            ) 0 list;
    findBasement = list: floor: count:
        if floor == -1 then count
        else if head list == "(" then
            findBasement (tail list) (floor + 1) (count + 1)
        else
            findBasement (tail list) (floor - 1) (count + 1);
    list = splitString "" input;
    output1 = calcFloor list;
    output2 = findBasement list 0 0;
in rec {
    inherit output1 output2;
}
