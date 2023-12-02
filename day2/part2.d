import std;

void main()
{
    int sum = 0;
    foreach(index, line; stdin.byLine.enumerate)
    {
        Cube[] game = line.parse();
        sum += game.findMin().power();
    }
    sum.writeln();
}

struct Cube
{
    int red;
    int green;
    int blue;

    int power() const
    {
        return red * green * blue;
    }
}

Cube[] parse(char[] line)
{
    auto parts = line.split(": ");
    Cube[] game;
    foreach(set; parts[1].splitter("; "))
    {
        auto cube = Cube(0, 0, 0);
        foreach(color; set.splitter(", "))
        {
            if(color.canFind("blue"))
            {
                color.formattedRead!"%d blue"(cube.blue);
            }
            if(color.canFind("red"))
            {
                color.formattedRead!"%d red"(cube.red);
            }
            if(color.canFind("green"))
            {
                color.formattedRead!"%d green"(cube.green);
            }
        }
        game ~= cube;
    }
    return game;
}

unittest
{
    assert("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green".dup().parse() == [
        Cube(4, 0, 3),
        Cube(1, 2, 6),
        Cube(0, 2, 0)
    ]);
}

Cube findMin(Cube[] game)
{
    return Cube(
        game.map!(cube => cube.red).reduce!max,
        game.map!(cube => cube.green).reduce!max,
        game.map!(cube => cube.blue).reduce!max
    );
}

unittest
{
    auto games = [
        [Cube(4, 0, 3), Cube(1, 2, 6), Cube(0, 2, 0)],
        [Cube(0, 2, 1), Cube(1, 3, 4), Cube(0, 1, 1)],
        [Cube(20, 8, 6), Cube(4, 13, 5), Cube(1, 5, 0)],
        [Cube(3, 1, 6), Cube(6, 3, 0), Cube(14, 3, 15)],
        [Cube(6, 3, 1), Cube(1, 2, 2)]
    ];
    assert(games[0].findMin() == Cube(4, 2, 6));
    assert(games[1].findMin() == Cube(1, 3, 4));
    assert(games[2].findMin() == Cube(20, 13, 6));
    assert(games[3].findMin() == Cube(14, 3, 15));
    assert(games[4].findMin() == Cube(6, 3, 2));
}
