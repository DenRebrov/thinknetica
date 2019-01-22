letters = {}
alphabet = ("a".."z")
vowels = ["a", "e", "i", "o", "u", "y"]

alphabet.each_with_index do |letter, index|
  vowels.each do |vowel|
    letters[letter] = index + 1 if letter == vowel
  end
end

#puts letters
