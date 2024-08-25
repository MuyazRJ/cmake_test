MODULE module1
    use module2
    implicit none

    contains

    subroutine call_print_a()
        CALL print_a()
    end subroutine call_print_a
END MODULE module1