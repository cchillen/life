program life
!
! Purpose:
!   Implementation of Conway's Game of Life in Fortran 90.
!
! Record of revisions:
!   Date        Programer       Description of change
!   ====        =========       =====================
!   2019-11-27  cchillen        Original Code
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


end program life

function createBoard(rows, cols)
    integer, intent(in) :: rows, cols
    logical, dimension(:,:), allocatable :: board

    createBoard = allocate( board(rows, cols) )

end function createBoard

function stepBoard(board)
    logical, dimension(:,:), intent(in) :: board
    logical, dimension(:,:), allocatable :: stepBoard

end function stepBoard

subroutine printBoard(board)
! printBoard - Clears terminal screen and then prints board
!
! Inputs:
!   board - 2D array of logicals that represents state of game.
implicit none

    logical, dimension(:,:), intent(in) :: board
    integer :: i, j

    ! Clear Screen
    call system('clear')

    ! Print Board
    do i = lbound(board,1), ubound(board,1)
        do j = lbound(board,2), ubound(board,2)
            if (board(i,j)) then
                write(*,*) '*' ! Life Cell is *
            else
                write(*,*) ' ' ! Dead cell is blank
            end if
        end do
        write(*,*) '\n' ! Line feed after current row
    end do

end subroutine printBoard