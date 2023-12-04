import std;

void main()
{
    int[][][] game;
    foreach(line; stdin.byLine)
    {
        char[][] parts = line[9 .. $].strip().split(" | ");
        //writeln(parts);
        int[] winning = parts[0].splitter().map!(to!int).array();
        int[] input = parts[1].splitter().map!(to!int).array();
        game ~= [winning, input];
    }
    game.countCards().values().sum.writeln();
}

int countMatching(int[] input, int[] winning)
{
    input.sort();
    winning.sort();
    int[] matches = setIntersection(input, winning).array;
    return cast(int) matches.length;
}

int[int] countCards(int[][][] game)
{
    int[int] cards;
    foreach(i, row; game)
    {
        int card = cast(int)(i + 1);
        cards[card] = 1;
    }

    foreach(i, row; game)
    {
        int card = cast(int)(i + 1);
        int[] winning = row[0];
        int[] input = row[1];
        int points = input.countMatching(winning);
        foreach(p; 0 .. points)
        {
            foreach(copy; 0 .. cards[card])
            {
                cards[card + p + 1]++;
            }
        }
    }
    return cards;
}

unittest
{
    auto game = [
        [[41, 48, 83, 86, 17], [83, 86,  6, 31, 17,  9, 48, 53]],
        [[61, 30, 68, 82, 17, 32, 24, 19], [13, 32, 20, 16, 61]],
        [[69, 82, 63, 72, 16, 21, 14,  1], [ 1, 21, 53, 59, 44]],
        [[59, 84, 76, 51, 58,  5, 54, 83], [41, 92, 73, 84, 69]],
        [[87, 83, 26, 28, 32], [88, 30, 70, 12, 93, 22, 82, 36]],
        [[31, 18, 13, 56, 72], [74, 77, 10, 23, 35, 67, 36, 11]]
    ];
    assert(countCards(game) == [
        1: 1,
        2: 2,
        3: 4,
        4: 8,
        5: 14,
        6: 1
    ]);
}
