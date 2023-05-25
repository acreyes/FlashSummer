#!/usr/bin/env python3

def dot(a,b):

    # note we're assuming a,b same size
    dot_product = 0.
    for i in range(len(a)):
        dot_product += a[i]*b[i]

    return dot_product


def printMat(A):
    for i in range(len(A)):
        print(A[i])

if __name__ == '__main__':

    a = [1.,2.,3.]
    b = [4.,5.,6.]

    print("a: ", a)
    print("b: ", b)
    print("a.b: ", dot(a,b) )

    A = [ [1.,2.,3.], \
          [4.,5.,6.], \
          [7.,8.,9.] ]

    B = [ [3.,2.,1.], \
          [6.,5.,4.], \
          [9.,8.,7.] ]

    print("A:")
    printMat(A)
    print("B:")
    printMat(B)
    print("A.B:")
    # printMat(matmul(A,B))
