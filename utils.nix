let inherit(builtins)
    filter
    foldl'
    getAttr
    head
    isString
    split
    tail
    ;
in rec {
    _digitValues = { "0"=0; "1"=1; "2"=2; "3"=3; "4"=4; "5"=5; "6"=6; "7"=7; "8"=8; "9"=9; };
    # Convert a digit to its value
    digitValue = digit: getAttr digit _digitValues;

    _enumerate = n: list_out: list_in:
        if list_in == [] then list_out
        else _enumerate (n + 1) (list_out ++ [{enum=n; value=head list_in;}]) (tail list_in);
    # Enumerate a list into attrSets of { enum= value= }
    enumerate = _enumerate 0 [];

    # Calculate power of x^n
    power = x: n: if n == 0 then 1 else x * (power x (n - 1));

    _reverse = list_out: list_in:
        if list_in == [] then list_out
        else _reverse ([(head list_in)] ++ list_out) (tail list_in);
    # Reverse a list
    reverse = _reverse [];

    # Split a string, by splitter
    splitString = splitter: string: filter (x: isString x && x != "" && x != "\n") (split splitter string);

    # Convert string to int
    stringToInt = string: foldl'
        (x: y: x + ((power 10 y.enum) * y.value))
        0
        (enumerate (reverse (map (x: digitValue x) (splitString "" string))));
}