︠b1743f54-36de-4a70-8c96-a001e3f8a8f6s︠
import copy

def print_Tableaux(Ins_Tab):
    if Ins_Tab is None:
        print "None"
        return None
    if Ins_Tab is "Impossible":
        print "Impossible"
        return None
    
    Ins_Sym_Tab = []
    for row in range(len(Ins_Tab)):
        Ins_Sym_Tab.append(" ")

        for number in Ins_Tab[row]:
            if number in ZZ and number != 0:
                Ins_Sym_Tab[row] += (str(number)+'  ')
            elif number == 0:
                Ins_Sym_Tab[row] += ('   ')
            else:
                Ins_Sym_Tab[row]+=(str(round(number+0.5))+"\' ")
    for string in Ins_Sym_Tab:
        print(string)


def F_Operator_SPSSYT_directly(SPSSYT_Tableaux, operator_index):

    T = copy.deepcopy(SPSSYT_Tableaux)
    length = len(T[0]) + 1
    for i in range(len(T)):
        len_temp = len(T[i])
        T[i] += [0] * (length-len_temp)
    T.append([0]*length)

    ind=operator_index
    read_word=[]
    for column in range(len(T[0])-1, -1, -1):
        for row in range(len(T)):
            if T[row][column] == ind-0.5 or T[row][column] == ind+0.5:
                read_word.append([float(T[row][column]+0.5),row,column])

    for row in range(len(T)-1, -1, -1):
        for column in range(len(T[0])):
            if T[row][column] == ind or T[row][column] == ind + 1:
                read_word.append([T[row][column],row,column])


    element_to_change=[0,0,0]
    count=0
    for element in read_word:
        if element[0] == ind +1:
            count += 1
        else:
            if count == 0:
                element_to_change = element
            else:
                count -= 1

    if element_to_change == [0,0,0]:
        return None
    print element_to_change
    [elt,row,column] =  element_to_change

    # Case 1
    if (T[row][column] == ind) and (T[row][column+1] >= ind + 1 or T[row][column+1]==0) and (T[row+1][column] > ind + 1 or T[row+1][column] ==0):
        T[row][column] = ind+1

    # Case 1'
    elif (T[row][column] == ind - 0.5) and (T[row][column+1] >= ind + 1 or T[row][column+1]==0) and (T[row+1][column] > ind or T[row+1][column] ==0):
        T[row][column] = float(ind + 0.5)

    # Case 2
    elif (T[row][column] == ind) and (T[row][column+1]==ind+0.5):
        T[row][column+1] = ind+1
        T[row][column] = float(ind+0.5)

    # Case 2'
    elif (T[row][column] == ind - 0.5) and (T[row+1][column] == ind):
        T[row][column] = ind
        T[row+1][column] = float(ind + 0.5)

    # Case 3
    elif (T[row][column] == ind) and (T[row][column+1] >= ind + 1 or T[row][column+1]==0) and (T[row+1][column] <= ind + 1):
        stop=0
        (temp_row,temp_column)=(row,column)
        while stop==0:
            if ind+0.5 not in T[temp_row+1]:
                stop=1
            elif T[temp_row+1][temp_column] > ind+1:
                stop=1
            else:
                temp_row += 1
                temp_column = T[temp_row].index(ind+0.5)
        if T[temp_row+1][temp_column] == ind+1 and T[temp_row+1][temp_row+1] == ind+1:
            T[row][column] = float(ind + 0.5)
        elif T[temp_row+1][temp_column] != ind+1:
            T[row][column] = float(ind + 0.5)
            T[temp_row][temp_column] = ind+1
        else:
            return "Impossible"

    # Case 3'
    elif (T[row][column] == ind-0.5) and (T[row+1][column] > ind or T[row+1][column] ==0) and (T[row][column+1] == ind+0.5):
        stop=0
        (temp_row,temp_column)=(row,column+1)
        while stop==0 and temp_row>0:
            if ind+0.5 not in T[temp_row-1]:
                stop=1
            elif T[temp_row-1][temp_column] < ind:
                stop=1
            else:
                temp_row -= 1
                temp_column = T[temp_row].index(ind+0.5)
        if temp_row>0 and T[temp_row-1][temp_column] == ind:
            temp_row -= 1
            while T[temp_row][temp_column+1]==ind:
                temp_column += 1
            T[row][column] = ind
            T[temp_row][temp_column] = float(ind+0.5)
        else:
            return "Impossible"

    else:
        return "Impossible"

    for row1 in T:
        for number1 in row1:
            number1 = round(number1,1)

    return T


w = [[1,1,1,1,2.5],[0,2,2,2,2.5],[0,0,3,3]]
print_Tableaux(w)
Tableaux = F_Operator_SPSSYT_directly(w,2)
print_Tableaux(Tableaux)
︡eb60d587-c8eb-44d9-b77b-9a41e2e0eb4c︡{"stdout":" 1  1  1  1  3' \n    2  2  2  3' \n       3  3  \n"}︡{"stdout":"None\n"}︡{"done":true}︡
︠67a5ec58-9a34-4a10-b54a-d20a161bacc2︠










