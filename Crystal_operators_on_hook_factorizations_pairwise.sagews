︠bc709ffe-34c6-4106-a25f-9c8b7cab9eaes︠
import copy

def if_hook_word(word):
    i=0
    while i < len(word)-1 and word[i] > word[i+1]:
        i += 1
    while i < len(word)-1:
        if word[i] > word[i+1]:
            return 'FALSE'
        i += 1
    return 'TRUE'



def EG_Increasing_Bump(Increasing_Word, letter):
    T=copy.deepcopy(Increasing_Word)
    k=copy.copy(letter)
    i=0
    if T==[]:
        return ([k],None)
    while T[i] <= k and i<len(T)-1:
        i+=1
    if i==len(T)-1 and T[i] <= k:
        i+=1

    if i==0:
        l=T[i]
        T[i]=k
        k=l
    if i>0 and i<len(T):
        if T[i-1]<k:
            l=T[i]
            T[i]=k
            k=l
        if T[i-1]==k:
            if T[i]>k+1:
                return ('ERROR','ERROR')
            k+=1

    if i==len(T):
        if T[i-1]==k:
            return ('ERROR','ERROR')
        T.append(k)
        k = None
    return (k,T)

def Inverse_EG_Increasing_Bump(letter, Increasing_Word):
    word=copy.deepcopy(Increasing_Word)
    i=0
    if word==[]:
        return ('ERROR','ERROR')
    if word[0]>letter:
        return('ERROR','ERROR')
    while i<len(word)-1 and word[i+1] < letter:
        i+=1
    if i==len(word)-1 or word[i+1] != letter:
        bumped_letter = word[i]
        word[i] = letter
    elif word[i+1]==letter and word[i]==letter-1:
        bumped_letter = letter-1
    else:
        return('ERROR','ERROR')
    return (word,bumped_letter)

def EG_Hook_Bump(hook_word, letter):
    if if_hook_word(hook_word) == 'FALSE':
        return ('ERROR','ERROR')
    word = copy.copy(hook_word)

    if if_hook_word(word+[letter]) == 'TRUE':
        return (None, word+[letter])

    valley=1
    while word[valley-1] > word[valley]:
        valley += 1

    word_decreasing = word[0:valley]
    word_increasing = word[valley: len(word)]
    if valley>1 and word[valley-2]==1 and word[valley-1]==0 and word[valley]==1 and letter==0:
        return (0, word)
    else:
        (k,new_word_increasing) = EG_Increasing_Bump(word_increasing,letter)
    if k == 'ERROR':
        return ('ERROR','ERROR')
    k *= -1

    for i in range(len(word_decreasing)):
        word_decreasing[i] *= -1

    (bumped_letter, new_word_decreasing) = EG_Increasing_Bump(word_decreasing, k)
    if bumped_letter == 'ERROR':
        return ('ERROR','ERROR')

    for i in range(len(new_word_decreasing)):
        new_word_decreasing[i] *= -1
    bumped_letter *= -1
    new_word = new_word_decreasing + new_word_increasing
    return (bumped_letter, new_word)

def Inverse_EG_Hook_Bump(letter, hook_word):
    word = copy.copy(hook_word)
    word.reverse()
    (bumped_letter, new_word) = EG_Hook_Bump(word, letter)
    new_word.reverse()
    return (new_word,bumped_letter)


def F_Operator_hook_factorizations_pairwise(factorization, operator_index):
    # Example factorization = [[+, 4, 2, 1, 2, 3],[], [-, 2, 0, 4, 5],[+, 3, 7]]
    if factorization == None:
        return None
    fact = copy.deepcopy(factorization)
    if len(factorization) < operator_index:
        return None
    elif len(factorization) == operator_index:
        factorization.append([])
    word_1 = copy.deepcopy(factorization[operator_index-1])
    word_2 = copy.deepcopy(factorization[operator_index])
    if len(word_1) > 2 and len(word_2)>0:
        sign_1 = word_1.pop(0)
        sign_2 = word_2.pop(0)
        if if_hook_word(word_1+word_2)=='TRUE':
            letter = word_1.pop(-1)
            word_2.insert(0,letter)
        else:
            if word_2[0] > word_1[-1]:
                prime = 'TRUE'
                letter = word_2.pop(0)
                word_1.append(letter)
            else:
                prime = 'FALSE'
            word_0 = []
            while len(word_2)>0 and if_hook_word(word_1 + word_2) == 'FALSE':
                letter = word_2.pop(0)
                (bumped_letter,word_1) = EG_Hook_Bump(word_1,letter)
                word_0.append(bumped_letter)

            #print (word_0,word_1,word_2,prime)

            if len(word_0) == len(word_1)-1 and prime == 'TRUE':
                return None
            elif len(word_0)==len(word_1)-1 and prime =='FALSE':
                while len(word_0)>0:
                    letter = word_0.pop(-1)
                    (word_1,bumped_letter) = Inverse_EG_Hook_Bump(letter, word_1)
                    word_2.insert(0,bumped_letter)
                letter = word_1.pop(-1)
                word_2.insert(0,letter)
            elif len(word_0)==len(word_1)-2 and prime == 'TRUE':
                return None
            elif len(word_0) < len(word_1)-2 and prime == 'TRUE':
                letter = word_1.pop(-1)
                word_2.insert(0,letter)
                while len(word_0)>0:
                    letter = word_0.pop(-1)
                    (word_1,bumped_letter) = Inverse_EG_Hook_Bump(letter, word_1)
                    word_2.insert(0,bumped_letter)
                letter = word_1.pop(-1)
                word_2.insert(0,letter)
            elif len(word_0) < len(word_1)-1 and prime =='FALSE':
                letter = word_1.pop(-1)
                word_2.insert(0,letter)
                while len(word_0)>0:
                    letter = word_0.pop(-1)
                    (word_1,bumped_letter) = Inverse_EG_Hook_Bump(letter, word_1)
                    word_2.insert(0,bumped_letter)
        word_1.insert(0,sign_1)
        word_2.insert(0,sign_2)

    elif len(word_2)==0 and len(word_1)>2:
        letter = word_1.pop(-1)
        word_2 = ['+', letter]
    elif len(word_2)==0 and len(word_1)==2:
        word_2 = word_1
        word_1 = []
    elif len(word_2)==0 and len(word_1)==0:
        return None
    elif len(word_1)==2 and len(word_2) > 0:
        sign_1 = word_1.pop(0)
        sign_2 = word_2.pop(0)
        if if_hook_word(word_1+word_2)=='TRUE':
            if sign_2 =='-':
                return None
            if sign_2 =='+':
                letter = word_1[0]
                word_2.insert(0,letter)
                word_1 = []
                word_2.insert(0,sign_1)
        else:
            return None
    elif len(word_1)==0:
        return None
    fact[operator_index-1] = word_1
    fact[operator_index] = word_2
    return fact

def foper(word,ind):
    return F_Operator_hook_factorizations_pairwise(word,ind)

def phi(word,ind):
    count = -1
    while word != None:
        word = foper(word,ind)
        count += 1
    return count


def Check_If_Crystal(highest_weight_hook_factorization_with_3_factors):
    # Example: [['+', 3,2,1,0,1,2,3,4],['+',1,3],['+',2]]
    high_word = highest_weight_hook_factorization_with_3_factors
    i=0
    Layer = [[]]
    Layer[0] = [high_word]
    while Layer[i] != []:
        print "Elements in Layer %i are:" %i
        for word in Layer[i]:
            print word
        Layer.append([])
        for word in Layer[i]:
            word_1 = foper(word,1)
            word_2 = foper(word,2)
            if word_1 != None and word_2 !=None:
                word_12 = foper(word_1,2)
                word_21 = foper(word_2,1)
                if word_12 != word_21:
                    word_1221 = foper(foper(word_12,2),1)
                    word_2112 = foper(foper(word_21,1),2)
                    if word_1221 != word_2112:
                        print 'Fail'
                        print word
                        print (word_12,word_21)
                        print (word_1221,word_2112)
                        return 'Not a crystal'
            if word_1 != None and word_1 not in Layer[i+1]:
                Layer[i+1].append(word_1)
            if word_2 != None and word_2 not in Layer[i+1]:
                Layer[i+1].append(word_2)
        i += 1
    return "Is a crystal"
︡5f7ea3f2-36ca-47eb-95c8-a4c3ef951f2c︡{"done":true}︡
︠ad0796b0-3757-4830-9a69-b4c12f5d2b81s︠

word_1 = foper([['+',4,3],['+',2,1,0,4],['+',2,1,2,3]],1)
print word_1

︡fd7781a6-7a50-4441-a196-953b7ee3451d︡{"stdout":"[['+', 4], ['+', 3, 2, 1, 0, 4], ['+', 2, 1, 2, 3]]\n"}︡{"done":true}︡
︠97b47ce0-150a-4878-9e4d-a4a7233eab0as︠

Check_If_Crystal ([['+', 4,1,2,3],[],[]])


︡a799b216-bdad-402a-ade9-536a7236a55c︡{"stdout":"Elements in Layer 0 are:\n[['+', 4, 1, 2, 3], [], []]\nElements in Layer 1 are:\n[['+', 4, 1, 2], ['+', 3], []]\nElements in Layer 2 are:\n[['+', 4, 1], ['+', 2, 3], []]\n[['+', 4, 1, 2], [], ['+', 3]]\nElements in Layer 3 are:\n[['+', 4], ['+', 1, 2, 3], []]\n[['+', 4, 1], ['+', 2], ['+', 3]]\nElements in Layer 4 are:\n[[], ['+', 4, 1, 2, 3], []]\n[['+', 4], ['+', 1, 2], ['+', 3]]\n[['+', 4, 1], [], ['+', 2, 3]]\nElements in Layer 5 are:\n[[], ['+', 4, 1, 2], ['+', 3]]\n[['+', 4], ['+', 1], ['+', 2, 3]]\nElements in Layer 6 are:\n[[], ['+', 4, 1], ['+', 2, 3]]\n[['+', 4], [], ['+', 1, 2, 3]]\nElements in Layer 7 are:\n[[], ['+', 4], ['+', 1, 2, 3]]\nElements in Layer 8 are:\n[[], [], ['+', 4, 1, 2, 3]]\n'Is a crystal'\n"}︡{"done":true}︡
︠767d9162-4a81-4ec0-b32b-926d4529b16b︠

︡a1afdc92-a4ce-4c6a-963c-b0a181025a2b︡
︠ac16c02f-7c81-47a6-99d5-db14d498a044︠

word = [['+',2,3,4],['+',1],['+',3]]
print (word,phi(word,1),phi(word,2))
word_1 = foper(word, 1)
word_11 = foper(word_1, 1)
print (word_1,phi(word_1,1),phi(word_1,2))
word_2 = foper(word, 2)
print (word_2,phi(word_2,1),phi(word_2,2))
word_12 = foper(word_1,2)
word_12
word_21 = foper(word_2,1)
word_21
word_12 == word_21
word_1221 = foper(foper(word_12,2),1)
print word_1221
word_2112 = foper(foper(word_21,1),2)
print word_2112
word_1221 == word_2112
︡fc80ec6b-06e9-4eea-8258-224c8714ce9a︡
︠93261b90-d252-4436-b302-2bc9861c8308︠

︡811e65b1-0c82-4718-b189-fcefaef8c0c0︡











