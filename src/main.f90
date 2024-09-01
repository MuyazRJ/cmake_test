! main_program.f90

program main
    use ma
    implicit none

    real :: x, y, sum, product

    x = 3.0
    y = 4.0

    sum = add(x, y)
    product = multiply(x, y)

    print *, "Sum:: ", sum
    print *, "Product:: ", product
end program main
