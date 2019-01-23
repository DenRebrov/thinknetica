letters = {}
alphabet = ("a".."z")
vowels = ["a", "e", "i", "o", "u", "y"]

alphabet.each.with_index(1) do |letter, index|
  letters[letter] = index if vowels.include?(letter)
end

#puts letters
