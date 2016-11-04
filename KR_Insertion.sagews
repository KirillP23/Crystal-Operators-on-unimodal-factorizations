︠7a13a03f-d03d-491e-824f-6325bc0a9697s︠
import copy

def EG_Row_Insertion(row,letter):
    T = copy.deepcopy(row)
    k = letter
    j=0
    if T==[]:
        return [[k],'None']
    while j < len(T) and T[j] <= k:
        j+=1
    if j==0:
        l=T[j]
        T[j]=k
        k=l

    if j>0 and j<len(T):
        if T[j-1]<k:
            l=T[j]
            T[j]=k
            k=l
        if T[j-1]==k:
            if T[j]>k+1:
                return ['ERROR','None']
            k+=1
    if j==len(T):
        if T[j-1]==k:
            return ['ERROR','None']
        T.append(k)
        k = 'None'
    return [T,k]


def KR_Row_Insertion(row,letter):
    index = 0
    end_ind = len(row)
    if len(row)==1:
        valley_ind=1
    else:
        while index < len(row)-1 and row[index] > row[index+1]:
            index += 1
        valley_ind = index+1

    if valley_ind >= 2 and valley_ind < end_ind and row[valley_ind] == 1 and row[valley_ind-1] == 0 and row[valley_ind-2] == 1 and letter ==0:
        return [row, 0]
    [end_row,letter] = EG_Row_Insertion(row[valley_ind : end_ind], letter)

    if end_row == 'ERROR':
        return ['ERROR','None']

    if letter == 'None':
        new_row = row[0:valley_ind] + end_row

    else:
        row1 = [x*(-1) for x in row[0:valley_ind]]
        letter *= -1

        [start_row1, letter] = EG_Row_Insertion(row1, letter)
        if start_row1 == 'ERROR':
            return ['ERROR','None']
        start_row = [x*-1 for x in start_row1]
        letter *= -1
        new_row = start_row + end_row
    return [new_row,letter]

def KR_Factor_Insertion(P_Tableaux, Q_Tableaux, factor, factor_ind, sign):
    list_of_rows=[]
    for letter in factor:

        row_ind=0
        while letter != 'None' and row_ind < len(P_Tableaux):
            [P_Tableaux[row_ind],letter] = KR_Row_Insertion(P_Tableaux[row_ind],letter)
            if P_Tableaux[row_ind]=='ERROR':
                print 'Error: Not a reduced word'
                return 'ERROR'
            row_ind += 1

        if letter == 'None':
            list_of_rows.append(row_ind-1)
        else:
            P_Tableaux.append([letter])
            list_of_rows.append(row_ind)

    peak_ind=0
    while peak_ind < len(list_of_rows)-1 and list_of_rows[peak_ind+1] > list_of_rows[peak_ind]:
        peak_ind += 1

    for row_ind in list_of_rows[0:peak_ind]:
        Q_Tableaux[row_ind].append(round(factor_ind-0.5,1))
    row_ind=list_of_rows[peak_ind]

    if len(P_Tableaux)>len(Q_Tableaux):
        Q_Tableaux.append([])

    if sign=='+':
        Q_Tableaux[row_ind].append(factor_ind)
    elif sign=='-':
        Q_Tableaux[row_ind].append(round(factor_ind-0.5,1))
    else:
        return 'Sign Error'
    for row_ind in list_of_rows[peak_ind+1:]:
        Q_Tableaux[row_ind].append(factor_ind)

def KR_Insertion(factorization):
    P_Tableaux = []
    Q_Tableaux = []
    index=0
    while factorization[index] == []:
        index += 1
    while index < len(factorization):
        sign = factorization[index].pop(0)
        KR_Factor_Insertion(P_Tableaux, Q_Tableaux, factorization[index], index+1,sign)
        factorization[index] = [sign] + factorization[index]
        while index < len(factorization)-1 and factorization[index+1] == []:
            index +=1
        index += 1
    return (P_Tableaux, Q_Tableaux)

KR_Insertion([[],['+', 2,1,0,1,3]])
︡86829b92-755b-4a88-af5c-a0f5dba28110︡{"stdout":"([[2, 1, 0, 1, 3]], [[2, 2, 2, 2, 2]])\n"}︡{"done":true}︡
︠0074e37a-548e-45af-8b9d-6bdb7c5e15d8s︠

def KR_Inverse_Factor_Insertion(P_Tableaux,Q_Tableaux, factor_ind):
    list_of_rows=[]
    factor=[]
    for row_ind in range(len(Q_Tableaux)):
        while len(Q_Tableaux[row_ind])!=0 and Q_Tableaux[row_ind][-1]==factor_ind:
            list_of_rows.append(row_ind)
            Q_Tableaux[row_ind].pop(-1)
    if len(Q_Tableaux[-1])==0:
        Q_Tableaux.pop(-1)

    peak_ind=len(list_of_rows)-1

    for row_ind in range(len(Q_Tableaux)-1,-1,-1):
        while len(Q_Tableaux[row_ind])!=0 and Q_Tableaux[row_ind][-1] == factor_ind-0.5:
            list_of_rows.append(row_ind)
            Q_Tableaux[row_ind].pop(-1)
    if len(Q_Tableaux)>0 and len(Q_Tableaux[-1])==0:
        Q_Tableaux.pop(-1)

    if list_of_rows==[]:
        return []


    if peak_ind==len(list_of_rows)-1 or list_of_rows[peak_ind] > list_of_rows[peak_ind+1]:
        sign='+'
    else:
        sign='-'

    for row_ind in list_of_rows:
        letter=P_Tableaux[row_ind].pop(-1)
        for sub_row_ind in range(row_ind-1,-1,-1):
            P_Tableaux[sub_row_ind].reverse()
            [P_Tableaux[sub_row_ind],letter] = KR_Row_Insertion(P_Tableaux[sub_row_ind],letter)
            if letter=='None':
                return 'ERROR'
            P_Tableaux[sub_row_ind].reverse()
        factor.append(letter)

    if len(P_Tableaux[-1])==0:
        P_Tableaux.pop(-1)

    factor.reverse()
    factor = [sign]+factor
    return factor


def KR_Inverse_Insertion(P_Tableaux, Q_Tableaux):
    max_list = [max(row) for row in Q_Tableaux]
    max_ind = max(max_list)
    if max_ind not in ZZ:
        max_ind = max_ind+0.5
    factorization = []
    for factor_ind in range(max_ind,0,-1):
        factorization = [KR_Inverse_Factor_Insertion(P_Tableaux,Q_Tableaux, factor_ind)] + factorization
    return factorization

P_T = [[3,2,0,1,2,3],[2,0,1]]
Q_T = [[1,1,1,1,1,2],[float(1.5),2,2]]
KR_Inverse_Insertion(P_T,Q_T)
︡85b99bd3-07c7-4a0f-b7ec-e4da1c9e8a6e︡{"stdout":"[['+', 2, 1, 0, 1, 3], ['-', 2, 0, 1, 3]]\n"}︡{"done":true}︡
︠ca45d9e9-7da8-4244-a042-4abad492525f︠

%load Crystal_SPSSYT.sage
%load HAI_Insertion.sage
%load HAI_Inverse_Insertion.sage

def E_Operator_Factorization(signed_hook_factorization, operator_index):
    if signed_hook_factorization =='Zero':
        return 'Zero'
    (P_Tableaux, Q_T) = KR_Insertion(signed_hook_factorization)
    sign_list =[]
    for index in range(len(Q_T)):
        if Q_T[index][0] in ZZ:
            sign_list.append('+')
        else:
            sign_list.append('-')
            Q_T[index][0] += 0.5
        Q_T[index] = [0]*index + Q_T[index]
    E_of_Q_T = E_Operator_SPSSYT(Q_T,operator_index)
    if E_of_Q_T is None:
        return 'Zero'

    E_of_Q_T.pop(-1)

    for index in range(len(E_of_Q_T)):
        E_of_Q_T[index] = E_of_Q_T[index][index:]

        if sign_list[index]=='-':
            E_of_Q_T[index][0] -= 0.5
        while E_of_Q_T[index][-1]==0:
            E_of_Q_T[index].pop(-1)

    E_of_SHF = KR_Inverse_Insertion(P_Tableaux,E_of_Q_T)
    return E_of_SHF

def F_Operator_Factorization(signed_hook_factorization, operator_index):
    if signed_hook_factorization =='Zero':
        return 'Zero'
    (P_Tableaux, Q_T) = KR_Insertion(signed_hook_factorization)
    sign_list =[]
    for index in range(len(Q_T)):
        if Q_T[index][0] in ZZ:
            sign_list.append('+')
        else:
            sign_list.append('-')
            Q_T[index][0] += 0.5
        Q_T[index] = [0]*index + Q_T[index]
    F_of_Q_T = F_Operator_SPSSYT(Q_T,operator_index)
    if F_of_Q_T is None:
        return 'Zero'

    F_of_Q_T.pop(-1)

    for index in range(len(F_of_Q_T)):
        F_of_Q_T[index] = F_of_Q_T[index][index:]
        if sign_list[index]=='-':
            F_of_Q_T[index][0] -= 0.5
        while F_of_Q_T[index][-1] == 0:
            F_of_Q_T[index].pop(-1)

    F_of_SHF = KR_Inverse_Insertion(P_Tableaux,F_of_Q_T)
    return F_of_SHF

w = [[ 1, 1, 1, 1, 1, 1.5, 3.5],[ 0, 2, 2, 2, 2, 3.5],[ 0, 0, 3, 3, 3, 3.5],[0,0,0,4,4.5,5.5]]
print E_Operator_SPSSYT(w,3)
︡ee608e11-2683-416f-99e3-c138c508f91e︡{"stdout":"[[1, 1, 1, 1, 1, 1.5, 2.5, 0], [0, 2, 2, 2, 2, 3.5, 0, 0], [0, 0, 3, 3, 3, 3.5, 0, 0], [0, 0, 0, 4, 4.5, 5.5, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]\n"}︡{"done":true}︡
︠a411cebc-fbee-432f-b8c0-d388c44a146d︠











