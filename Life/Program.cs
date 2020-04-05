using System;
using System.Threading;
using Life.Board;
using Life.Print;

namespace Life
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Game of Life");

            // Initialize Board
            Board.Board board = new Board.Board(80, 43);
            board.Initialize();


            int numGenerations = 300;

            for (int i = 0; i < numGenerations; i++){
                System.Console.WriteLine($"Generation {i}");
                Printer.Print(board.GetState());

                board.Step();

                Thread.Sleep(100);
            }
        }
    }
}
