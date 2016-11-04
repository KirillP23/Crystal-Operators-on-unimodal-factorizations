
import copy



def Letter_Insertion(Shifted_Primed_SSYT, Insertion_Letter):
    """
    Shifted primed SSYT should have zeros at the end of each row, row of zeros as the last row and equal number of elements in each row
    Example: Letter_Insertion([[ 2, 2.5, 3, 0],[0, 3, 0, 0], [ 0, 0, 0, 0]], 1) = [[ 1, 1.5, 2.5, 0], [0, 3, 3, 0], [ 0, 0, 0, 0]]
    """
    T=copy.deepcopy(Shifted_Primed_SSYT)
    k=copy.copy(Insertion_Letter)
    row=0
    column=0
    new_row=1
    new_column=1
    new_k=0
    while k != 0:

        if k in ZZ:

            j = row

            while 0 < T[row][j] <= k:
                j += 1

            if T[row][j] in ZZ and T[row][j] > 0:
                if j==row:
                    new_k = round(T[row][j] - 0.5, 1)
                    T[row][j] = k
                    new_column = j + 1

                else:
                    new_k = T[row][j]
                    T[row][j] = k
                    new_row = row + 1
            else:
                new_k = T[row][j]
                T[row][j] = k
                new_column = j+1
                new_row = row + 1


        else:
            k = round(k,1)
            i=0
            while 0 < T[i][column] <= k:
                i += 1

            if T[i][column] in ZZ:
                new_k = T[i][column]
                T[i][column] = k
                new_row = i + 1

            else:
                new_k = T[i][column]
                T[i][column] = k
                new_column = column + 1

        row = new_row
        column = new_column
        k = new_k

    if row == 1:
        for i in range(len(T)):
            T[i].append(0)

    if row == len(T):
        T.append([0] * len(T[0]))
    return(T)



def Word_Insertion(A_word):
    if A_word == 0:
        return 0
    Ins_Tab = [[0]]
    for letter in A_word:
        Ins_Tab = Letter_Insertion(Ins_Tab, letter)

    return Ins_Tab









