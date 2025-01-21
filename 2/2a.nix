let
    inherit (builtins)
        elemAt
        foldl'
        lessThan
        map
        readFile
        sort;
    inherit (import ../utils.nix)
        splitString
        stringToInt
        ;

    input = readFile ./input.txt;
    # input = readFile ./ex1;
    lines = splitString "\n" input;

    measurements = line: sort lessThan (map (x: stringToInt x) (splitString "x" line));

    wrappingPaper = line:
        let
            presentLengths = measurements line;
            elem = elemAt presentLengths;
        in
            2 * (((elem 0)*(elem 1)) + ((elem 0)*(elem 2)) +
                ((elem 1)*(elem 2))) + ((elem 0)*(elem 1));
    output1 = foldl' (x: y: x + wrappingPaper y) 0 lines;

    ribbonLength = line: let
        presentLengths = measurements line;
        elem = elemAt presentLengths;
    in
        2 * ((elem 0) + (elem 1)) + (foldl' (x: y: x * y) 1 presentLengths);
    output2 = foldl' (x: y: x + ribbonLength y) 0 lines;
in {
    inherit output1 output2;
}