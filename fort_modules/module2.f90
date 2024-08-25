MODULE module2
    implicit none
    integer :: a = 10

    contains

    subroutine print_a()
        print *, "a =", a 
    end subroutine print_a 
END MODULE module2