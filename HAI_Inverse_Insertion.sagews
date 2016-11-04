︠96dd0216-034e-4800-a529-9986f7f8607es︠

import copy

def Inverse_Letter_Insertion(Shifted_Primed_SSYT, Letter_Position):
    """"""
    #Shifted primed SSYT is in the format
    # [[ 1, 1, 1, 1.5, 2.5, 0],[ 0, 2, 2, 2.5, 0, 0],[ 0, 0, 3, 0, 0, 0], [0, 0, 0, 0, 0, 0]]
    # Letter position is in the format (0,4)
    # Algorithm returns new insertion tableaux together with bumped letter
    """"""
    T = copy.deepcopy(Shifted_Primed_SSYT)
    (row, column) = copy.copy(Letter_Position)

    if T[row][column + 1] != 0 or T[row+1][column] != 0 or T[row][column] == 0:
        return 'Error'

    k = T[row][column]
    T[row][column] = 0
    if row ==0:
        for i in range(len(T)):
            T[i].pop()
    if row == column:
        T.remove( T[row] )
    row = row-1
    column = column-1
    new_column=0
    new_row=0

    while row >= 0 or k not in ZZ:
        if k in ZZ:
            j=row

            while 0 < T[row][j+1] < k:
                j += 1

            if T[row][j] in ZZ:
                new_k = T[row][j]
                T[row][j] = k
                new_row = row - 1

            else:
                new_k = T[row][j]
                T[row][j] = k
                new_column = j-1

        else:
            k=round(k,1)
            i=0

            while 0 < T[i+1][column] < k:
                i += 1

            if T[i][column] in ZZ:
                if i == column:
                    new_k = T[i][column]
                    T[i][column] = round(k+0.5, 1)
                    new_row = i - 1
                else:
                    new_k = T[i][column]
                    T[i][column] = k
                    new_row = i - 1
            else:
                new_k = T[i][column]
                T[i][column] = k
                new_column = column - 1

        k = new_k
        row = new_row
        column = new_column
    k = int(k)
    return (T ,k)


def Inverse_RSK (Ins_Tab):
    """
    Shifted primed SSYT is in the format
    [[ 1, 1, 1, 2', 3'],[ 0, 2, 2, 3'],[ 0, 0, 3]]
    The algorithm returnes the A-type word with given Insertion Tableaux P and fixed (standard) reading tableaux Q
    Example: Inverse_RSK([[ 1, 1, 1, 1.5, 2.5],[ 0, 2, 2, 2.5],[ 0, 0, 3]] ) = [3,3,3,2,2,2,1,1,1]
    """
    P = copy.deepcopy(Ins_Tab)
    length = len(P[0]) + 1
    for row in P:
        newrow=[]
        for index in range(len(row)):
            if row[index]<0:
                row[index] = float(-row[index]-0.5)
        len_temp = len(row)
        row += [0] * (length-len_temp)
    P.append([0]*length)
    print P
    w = []
    while len(P) > 1:
        j = len(P[0]) - 2
        l = len(P)
        while j >= l-2 :
            i=0
            while P[i+1][j] != 0:
                i += 1

            (P,k) = Inverse_Letter_Insertion(P, (i,j))

            w.append(k)
            j -= 1
    w.reverse()

    return w

w= [[1,1,1,1,1,-2,-4,-5,-7],
   [0,2,2,2,2,-3,-5,-6],
   [0,0,3,3,3,-4],
   [0,0,0,4,-5,-6]]

Inverse_RSK(w)
︡3f75e5ca-d981-4f97-b0b5-36ce14c6ed0a︡{"stdout":"[[1, 1, 1, 1, 1, 1.5, 3.5, 4.5, 6.5, 0], [0, 2, 2, 2, 2, 2.5, 4.5, 5.5, 0, 0], [0, 0, 3, 3, 3, 3.5, 0, 0, 0, 0], [0, 0, 0, 4, 4.5, 5.5, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]\n[2, 1, 3, 5, 6, 7, 4, 3, 2, 5, 6, 4, 3, 1, 2, 2, 5, 4, 3, 2, 1, 1, 1]\n"}︡{"done":true}︡
︠592e52f3-d4b0-4d49-85ed-984e5911c328︠











