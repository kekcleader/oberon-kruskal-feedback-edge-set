MODULE VinniPuh;
IMPORT In, Out;
CONST intersectionMaxCount = 1000;
TYPE
  Road = RECORD
    inMST: BOOLEAN; (* TRUE if this edge does not need honey *)
    a, b: INTEGER;  (* Indices of vertices *)
    w: INTEGER      (* Weight, -99..99 *)
  END;
VAR
  n: INTEGER; (* Actual number of intersections *)
  roads: ARRAY 10000 OF Road; (* Input set *)
  m: INTEGER; (* Actual length of roads *)
  trees: ARRAY intersectionMaxCount + 1 OF INTEGER;
  readOk: BOOLEAN; (* If last integer read was successful *)
  c: CHAR; (* Read-ahead character *)

(** Reads a possibly negative integer from standard input.
    Sets readOk to FLASE on failure. *)
PROCEDURE InInt(VAR x: INTEGER);
VAR neg: BOOLEAN;
BEGIN
  (* Skip whitespaces *)
  WHILE In.Done & (c <= " ") DO In.Char(c) END;

  x := 0;
  neg := FALSE;
  IF In.Done & (c = "-") THEN
    neg := TRUE;
    In.Char(c)
  END;

  IF In.Done & ("0" <= c) & (c <= "9") THEN
    x := 0;
    WHILE In.Done & ("0" <= c) & (c <= "9") DO
      x := x * 10 + (ORD(c) - ORD("0"));
      In.Char(c)
    END;
    IF neg THEN x := -x END;
    readOk := In.Done
  ELSE
    readOk := FALSE;
    x := 0
  END
END InInt;

PROCEDURE ReadInputFile(): BOOLEAN;
VAR a, b, w: INTEGER;
BEGIN
  In.Open; In.Char(c); readOk := In.Done;
  m := 0;
  IF readOk THEN
    InInt(n);
    WHILE readOk DO
      InInt(a);
      IF readOk THEN
        roads[m].a := a; InInt(b);
        roads[m].b := b; InInt(w);
        roads[m].w := w;
        roads[m].inMST := FALSE;
        INC(m)
      END
    END
  END;
  RETURN n # 0
END ReadInputFile;

PROCEDURE OutputResult;
VAR i, W: INTEGER;
BEGIN
  (* Calcualte total W *)
  W := 0;
  FOR i := 0 TO m - 1 DO
    IF ~roads[i].inMST THEN
      INC(W, roads[i].w)
    END
  END;

  (* Output *)
  Out.Int(m - n + 1, 0); Out.Char(" ");
  Out.Int(W, 0); Out.Char(" ");
  FOR i := 0 TO m - 1 DO
    IF ~roads[i].inMST THEN
      Out.Char(" ");
      Out.Int(roads[i].a, 0);
      Out.Char(" ");
      Out.Int(roads[i].b, 0)
    END
  END;
  Out.Ln
END OutputResult;

PROCEDURE InitVertexTrees;
VAR i: INTEGER;
BEGIN
  (* Initially, every intersection is in its own tree *)
  FOR i := 1 TO n DO trees[i] := i END
END InitVertexTrees;

PROCEDURE UniteTwoTrees(a, b: INTEGER);
VAR i, tree: INTEGER;
BEGIN
  tree := trees[a];
  FOR i := 1 TO n DO
    IF trees[i] = tree THEN trees[i] := trees[b] END
  END
END UniteTwoTrees;

(* Sorts roads in descending order. *)
PROCEDURE QuickSort(begin, end: INTEGER);
VAR i, j, x: INTEGER;
  tmp: Road;
BEGIN
  i := begin; j := end;
  x := roads[(begin + end) DIV 2].w;
  REPEAT
    WHILE roads[i].w > x DO INC(i) END;
    WHILE roads[j].w < x DO DEC(j) END;
    IF i <= j THEN
      tmp := roads[i]; roads[i] := roads[j]; roads[j] := tmp;
      INC(i); DEC(j)
    END
  UNTIL i > j;
  IF begin < j THEN QuickSort(begin, j) END;
  IF i < end THEN QuickSort(i, end) END
END QuickSort;

PROCEDURE ParseGraph;
VAR i: INTEGER;
  left: INTEGER; (* Number of roads left to collect *)
  e: Road;
BEGIN
  QuickSort(0, m - 1);
  InitVertexTrees;
  i := 0; left := n - 1;
  WHILE left > 0 DO
    e := roads[i];
    IF trees[e.a] # trees[e.b] THEN
      UniteTwoTrees(e.a, e.b);
      roads[i].inMST := TRUE;
      DEC(left)
    END;
    INC(i)
  END
END ParseGraph;

PROCEDURE Do*;
BEGIN
  IF ~ReadInputFile() THEN
    Out.String("ERROR: Load input file"); Out.Ln
  ELSE
    ParseGraph;
    OutputResult
  END
END Do;

END VinniPuh.
