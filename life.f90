module mBoard
    implicit none

    contains

    function createBoard(rows, cols)

        logical, dimension(:,:), allocatable :: createBoard
        integer, intent(in) :: rows, cols
        integer :: r,c

        allocate( createBoard(rows, cols) )

        do c = 1,cols
            do r = 1,rows
                createBoard(r,c) = (nint(rand(0)) .eq. 0)
            end do
        end do

    end function createBoard

    function stepBoard(board)
    ! stepBoard - Determines the next sequence in the board
    !
    ! Inputs:
    !   board - 2D array of logicals that represents the state of the game.

        logical, dimension(:,:), intent(in) :: board
        logical, dimension(:,:), allocatable :: stepBoard

    end function stepBoard

    subroutine printBoard(board)
    ! printBoard - Clears terminal screen and then prints board
    !
    ! Inputs:
    !   board - 2D array of logicals that represents state of game.

        logical, dimension(:,:), intent(in) :: board
        integer :: i, j

        ! Clear Screen
        call system('clear')

        ! Print Board
        do i = lbound(board,1), ubound(board,1)
            do j = lbound(board,2), ubound(board,2)
                if (board(i,j)) then
                    write(*,"(A)", advance="no") '*' ! Life Cell is *
                else
                    write(*,"(A)", advance="no") ' ' ! Dead cell is blank
                end if
            end do
            write(*,*) '' ! Line feed after current row
        end do

    end subroutine printBoard
end module

program life
!
! Purpose:
!   Implementation of Conway's Game of Life in Fortran 90.
!
! Record of revisions:
!   Date        Programer       Description of change
!   ====        =========       =====================
!   2019-11-27  cchillen        Original Code
use mBoard

implicit none

integer :: rows, cols           ! Board size
logical, dimension (:, :), allocatable :: board ! Actual Board


! Basic Algorithm:
! 1. Prompt user to input board size
! 2. Initialize Board
! 3. Display Board
! 4. Step Board
! 5. Loop at step 3 or quit

! Functions: createBoard(), stepBoard(), printBoard()
rows = 10
cols = 10

board = createBoard(rows, cols)

call printBoard(board)


end program life
