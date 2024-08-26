module examples
    use module1
    implicit none

contains

    subroutine calls(outputs)
        integer, intent(out) :: outputs
        call call_print_a()
        outputs = 3
    end subroutine calls

    function calla() result(m)
        integer :: m  ! Declare 'm' as the result variable
    
        ! Assign a value to 'm' inside the function
        m = 3
    end function
    
    

end module examples
