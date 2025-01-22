# Oberon Kruskal Feedback Edge Set

The agorithm finds the minimum (with minimum weight) set of edges of a linked
non-oriented graph, such that in any cycle of the graph there is at least one
set from the given set.

## Usage

1. Download [Vostok Oberon compiler](https://vostok.oberon.org).
2. Execute `./run.sh` or:
```
ost to-bin 'VinniPuh.Do' vinnipuh -m .
./vinnipuh < 'in.txt' > 'out.txt'
```

## Input

Example of input file:
```
10
1 2 -32  1 3 63   2 3 55  1 4  44  2 4  36
3 4 99   1 5 -26  2 6 22  5 6  73  2 7  83
4 7 65   1 8 40   2 8 26  3 8  51  7 8  70
3 9 4    6 9 65   8 9 81  3 10 67  8 10 22
```

The first number is the number of vertices. Next follow tripples of numbers:
strting vertex of an edge, ending vertex of the edge and weight of the edge.

## Output

The output is first the number of edges in the result set, then the starting
and the ending vertices of the edges.

Example of output file:
```
11 242  2 3 3 8 1 4 1 8 2 4 2 8 8 10 2 6 3 9 1 5 1 2
```

Riga.

January, 2025

by Arthur Yefimov

Latvian State University
