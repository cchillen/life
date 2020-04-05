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

        logical, dimension(:,:), intent(inout), allocatable :: board
        logical, dimension(:,:), allocatable :: stepBoard
        integer :: i, j, livingNeighbors, x, y, rows, cols, a, b

        rows = ubound(board,1)
        cols = ubound(board,2)

        allocate(stepBoard(rows,cols))

        ! Iterate through board to determine next state
        do i=1,rows
            do j = 1,cols
                ! Determine how many neighbors a cell has
                livingNeighbors = 0

                do x = -1,1
                    do y = -1, 1
                        if ((x .eq. 0) .and. (y .eq. 0)) then
                            continue
                        else
                            ! mod can wrap around on the high side
                            ! need to figure out how to wrap around on the low side
                            if (i+x .eq. 0) then
                                a = rows
                            else
                                a = mod(i+x,rows)
                            end if

                            if (j+y .eq. 0) then
                                b = cols
                            else
                                b = mod(j+y,cols)
                            end if

                            if (board(a,b)) then
                                livingNeighbors = livingNeighbors + 1
                            end if
                            !if (board(mod(i+x, rows), mod(j+y, cols))) then
                            !    livingNeighbors = livingNeighbors + 1
                            !end if
                        end if
                    end do
                end do

                !write(*,*) livingNeighbors

                ! Determine which cells 'live' or 'die' based on the rules
                if (board(i,j) .and. livingNeighbors < 2) then
                    stepBoard(i,j) = .false.
                else if (board(i,j) .and. livingNeighbors < 4) then
                    stepBoard(i,j) = .true.
                else if (board(i,j)) then
                    stepBoard(i,j) = .false.
                else if ((.not. board(i,j)) .and. (livingNeighbors .eq. 3)) then
                    stepBoard(i,j) = .true.
                else
                    stepBoard(i,j) = .false.
                end if
            end do
        end do


        ! clean up input board before returning
        deallocate(board)

    end function stepBoard

    subroutine printBoard(board)
    ! printBoard - Clears terminal screen and then prints board
    !
    ! Inputs:
    !   board - 2D array of logicals that represents state of game.

        logical, dimension(:,:), intent(in) :: board
        integer :: i, j

        ! Clear Screen
        !call system('clear')
        write(*,"(A)") "==========================="

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
use, intrinsic :: iso_c_binding, only: c_int

implicit none

integer :: rows, cols           ! Board size
integer :: i
logical, dimension (:, :), allocatable :: board ! Actual Board


! Basic Algorithm:
! 1. Prompt user to input board size
! 2. Initialize Board
! 3. Display Board
! 4. Step Board
! 5. Loop at step 3 or quit

! Functions: createBoard(), stepBoard(), printBoard()
rows = 45
cols = 80

board = createBoard(rows, cols)

!call printBoard(board)

do i = 1,1000
    call printBoard(board)

    board = stepBoard(board)

    call sleep(1)

end do

end program life
