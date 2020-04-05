using System;

namespace Life.Board
{
    public enum CellState {
        Dead = 0,
        Alive = 1
    }

    public class Board
    {
        private readonly Random _randomNumberGenerator;
        private readonly CellState[,] _board;
        private readonly int _rows;
        private readonly int _cols;

        public Board(int rows, int cols){
            _board = new CellState[rows, cols];
            _rows = rows;
            _cols = cols;

            _randomNumberGenerator = new Random();
        }

        public void Initialize()
        {
            for (int r = 0; r < _rows; r++)
            {
                for (int c = 0; c < _cols; c++)
                {
                    _board[r,c] = _randomNumberGenerator.NextDouble() > 0.5 ? CellState.Dead : CellState.Alive;
                }
            }
        }

        public void Step()
        {
            CellState[,] _oldBoard = new CellState[_rows, _cols];
            Array.Copy(_board, _oldBoard, _board.Length);

            for (int r = 0; r < _rows; r++)
            {
                for (int c = 0; c < _cols; c++)
                {
                    int livingNeighbors = CalculateLivingNeighbors(_oldBoard, r, c);

                    if (_oldBoard[r,c] == CellState.Alive){
                        _board[r,c] = livingNeighbors == 2 || livingNeighbors == 3 ?
                            CellState.Alive : CellState.Dead;
                    }
                    else
                    {
                        _board[r,c] = livingNeighbors == 3 ? CellState.Alive : CellState.Dead;
                    }
                }
            }
        }

        private int CalculateLivingNeighbors(CellState[,] board, int r, int c){
            int livingNeighbors = 0;
            int numRows = board.GetLength(0);
            int numCols = board.GetLength(1);

            livingNeighbors += (int)board[mod(r-1, numRows), mod(c-1, numCols)];
            livingNeighbors += (int)board[r                , mod(c-1, numCols)];
            livingNeighbors += (int)board[mod(r+1, numRows), mod(c-1, numCols)];
            livingNeighbors += (int)board[mod(r-1, numRows), c];
            livingNeighbors += (int)board[mod(r+1, numRows), c];
            livingNeighbors += (int)board[mod(r-1, numRows), mod(c+1, numCols)];
            livingNeighbors += (int)board[r                , mod(c+1, numCols)];
            livingNeighbors += (int)board[mod(r+1, numRows), mod(c+1, numCols)];

            return livingNeighbors;
        }

        private int mod(int x, int m)
        {
            return (x % m + m) % m;
        }

        public CellState[,] GetState() => _board;
    }
}