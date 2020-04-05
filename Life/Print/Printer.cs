using System;
using Life.Board;

namespace Life.Print
{
    public static class Printer
    {
        public static void Print(CellState[,] board)
        {
            for (int r = 0; r < board.GetLength(0); r++)
            {
                for (int c = 0; c < board.GetLength(1); c++)
                {
                    char printChar = board[r,c] == CellState.Alive ? '*':' ';
                    System.Console.Write(printChar);
                }
                System.Console.WriteLine();
            }
        }
    }
}