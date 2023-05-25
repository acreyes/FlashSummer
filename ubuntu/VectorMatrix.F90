program VectorMatrix

    real, dimension(3)   :: a, b
    real, dimension(3,3) :: Ma, Mb

    a = (/ 1., 2., 3. /)
    b = (/ 4., 5., 6. /)

    print *, "a: ", a
    print *, "b: ", b
    print *, "a.b: ", dot(a,b)

    Ma(1,:) = (/ 1.,2.,3. /)
    Ma(2,:) = (/ 4.,5.,6. /)
    Ma(3,:) = (/ 7.,8.,9. /)

    Mb(1,:) = (/ 3.,2.,1. /)
    Mb(2,:) = (/ 6.,5.,4. /)
    Mb(3,:) = (/ 9.,8.,7. /)

    print *, "Ma:"
    call printMat(Ma)
    print *, "Mb:"
    call printMat(Mb)
contains

    function dot(u, w) result (dotProduct)
        real, dimension(:), intent(IN) :: u, w

        real    :: dotProduct
        integer :: i

        dotProduct = 0.
        do i = 1, size(u)
            dotProduct = dotProduct + u(i)*w(i)
        enddo
        return
    end function dot

    subroutine printMat(A)
        real, dimension(:,:) :: A

        integer :: i

        do i = 1, size(A,DIM=1)
            print *, A(i,:)
        enddo
    end subroutine printMat


end program VectorMatrix
