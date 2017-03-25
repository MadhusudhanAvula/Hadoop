def are_two_string_anagram(string1, string2):
    if len(string1) != len(string2):
        return False

    def char_count(string):
        char_count = {}
        for s in string:
            char_count[s] = char_count.get(s, 0) + 1
        return char_count

    chr_count = char_count(string1)
    chr1_count = char_count(string2)
    return chr_count == chr1_count

string1 = "silent"
string2 = "listen"
print(are_two_string_anagram(string1, string2))

string1 = "polo"
string2 = "loop"
print(are_two_string_anagram(string1, string2))

string1 = "madhu"
string2 = "Madhu"
print(are_two_string_anagram(string1, string2))