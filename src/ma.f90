! math_operations.f90

module ma
    implicit none
contains
    function add(a, b) result(sum)
        real, intent(in) :: a, b
        real :: sum
        sum = a + b
    end function add

    function multiply(a, b) result(product)
        real, intent(in) :: a, b
        real :: product
        product = a * b
    end function multiply
end module ma
