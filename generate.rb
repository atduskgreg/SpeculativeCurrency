require 'wordnik'

@money_words = open("money_words.txt").read.split(/\n/)

Wordnik.configure do |config| 
  config.api_key ="2d18e3ee331b2f508b0060063ab0d5f494e66641e0360eee7"
end


def generate_word
  excluded = ["past-participle", "pronoun", "article", "family-name", "given-name", "noun-plural", "proper-noun", "preposition"]
  
  word = Wordnik.words.get_random_word(:exclude_part_of_speech => excluded.join(","))["word"]
  
  definitions = Wordnik.word.get_definitions(word)
  definition = definitions.sample
  definition = definition["text"]
  
  definition[0] = definition[0].chr.downcase
  
  templates = ["A form of currency based on",
  "A payment scheme built on",
  "A medium of exchange that depends on",
  "An alternative currency based on",
  "A distributed ledger system implemented using",
  "A digital currency based on",
  "A new crypto currency employing"]
  
  valid_word = true
  if definition =~ /plural form/i
    valid_word = false
  end

  result = "#{word.capitalize} #{@money_words.sample.capitalize}\n#{templates.sample} #{definition}"

  if result.length > 140
    valid_word = false
  end

  if valid_word
    return result
  else
    return false
  end
end

word_generated = false

while !word_generated
  puts "generating"
  word_generated = generate_word
end