
def from_word_to_crystal(w,n):
    B = crystals.Letters(['A',n])
    l = len(w)
    T = crystals.TensorProduct(*[B]*l)
    return T(*[B(i) for i in w])

def from_crystal_to_word (w,n):
    B = crystals.Letters(['A',n])
    word = []
    for letter in w:
        for i in range(n+1):
            if letter is B(i):
                word.append(i)
    return word

def print_Tableaux(Ins_Tab):
    if Ins_Tab is None:
        print "None"
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





def F_Operator_SPSSYT (Shifted_Primed_SSYT, operator_index):
    """
    EXAMPLES::
    w = [[ 1, 1, 1, 1.5, 2.5],[ 0, 2, 2, 2.5],[ 0, 0, 3, 3]]
    print_Tableaux(w)
    print('Goes to')
    F_2_of_w = F_Operator_SPSSYT(w, 2)
    print_Tableaux(F_2_of_w)
    """
    reading_word = Inverse_RSK(Shifted_Primed_SSYT)
    crystal_index = max(reading_word)+1
    if crystal_index < operator_index:
        return None
    crystal_element=from_word_to_crystal(reading_word,crystal_index)
    F_of_crystal_element = crystal_element.f(operator_index)
    if F_of_crystal_element is None:
        return None
    F_of_reading_word = from_crystal_to_word(F_of_crystal_element,crystal_index)
    F_of_SPSSYT = Word_Insertion(F_of_reading_word)
    return F_of_SPSSYT


def E_Operator_SPSSYT (Shifted_Primed_SSYT, operator_index):
    reading_word = Inverse_RSK(Shifted_Primed_SSYT)
    crystal_index = max(reading_word)+1
    if crystal_index < operator_index:
        return 0
    crystal_element=from_word_to_crystal(reading_word,crystal_index)
    E_of_crystal_element = crystal_element.e(operator_index)
    if E_of_crystal_element is None:
        return None
    E_of_reading_word = from_crystal_to_word(E_of_crystal_element,crystal_index)
    E_of_SPSSYT = Word_Insertion(E_of_reading_word)
    return E_of_SPSSYT










