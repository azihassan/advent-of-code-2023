import std;

void main()
{
    int sum = 0;
    foreach(line; stdin.byLine)
    {
        char[][] parts = line[9 .. $].strip().split(" | ");
        //writeln(parts);
        int[] winning = parts[0].splitter().map!(to!int).array();
        int[] input = parts[1].splitter().map!(to!int).array();

        int points = countPoints(input, winning);
        //writeln("countPoints(", input, ", ", winning, ") = ", points);
        sum += points;
    }
    sum.writeln();
}

int countPoints(int[] input, int[] winning)
{
    input.sort();
    winning.sort();
    int[] matches = setIntersection(input, winning).array;
    if(matches.empty)
    {
        return 0;
    }
    int points = 1;
    foreach(match; matches[1 .. $])
    {
        points *= 2;
    }
    return points;
}

unittest
{
    int[] winning = [41, 48, 83, 86, 17];
    int[] input = [83, 86,  6, 31, 17,  9, 48, 53];

    int[] expected = [17, 48, 83, 86];
    writeln(input.countPoints(winning));
    assert(input.countPoints(winning) == 8);
    assert([61, 30, 68, 82, 17, 32, 24, 19].countPoints([13, 32, 20, 16, 61]) == 2);
    assert([69, 82, 63, 72, 16, 21, 14,  1].countPoints([ 1, 21, 53, 59, 44]) == 2);
    assert([59, 84, 76, 51, 58,  5, 54, 83].countPoints([41, 92, 73, 84, 69]) == 1);
    assert([1, 2].countPoints([3, 4]) == 0);
}

int[] findWinning(int[] input, int[] winning)
{
    input.sort();
    winning.sort();
    return setIntersection(input, winning).array();
}

unittest
{
    int[] winning = [41, 48, 83, 86, 17];
    int[] input = [83, 86,  6, 31, 17,  9, 48, 53];

    int[] expected = [17, 48, 83, 86];
    assert(input.findWinning(winning) == expected);
    assert([61, 30, 68, 82, 17, 32, 24, 19].findWinning([13, 32, 20, 16, 61]) == [32, 61]);
    assert([69, 82, 63, 72, 16, 21, 14,  1].findWinning([ 1, 21, 53, 59, 44]) == [1, 21]);
    assert([59, 84, 76, 51, 58,  5, 54, 83].findWinning([41, 92, 73, 84, 69]) == [84]);
}
