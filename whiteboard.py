# Complete the method/function so that it converts dash/underscore delimited words into camel casing. 
# The first word within the output should be capitalized only if the original word was capitalized 
# (known as Upper Camel Case, also often referred to as Pascal case). 
# The next words should be always capitalized.

# Examples
# "the-stealth-warrior" gets converted to "theStealthWarrior"
# "The_Stealth_Warrior" gets converted to "TheStealthWarrior"
# "The Stealth Warrior" gets converted to "TheStealthWarrior"

def solution(num):
    num -= 1
    sum_lst = []
    while num > 0:
        if num % 3 == 0:
            sum_lst.append(num)
        elif num % 5 == 0:
            sum_lst.append(num)
        num -= 1
    return sum(sum_lst)