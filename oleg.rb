require 'rubygems'
require 'movieDB/base.rb'
require 'engtagger'
require 'themoviedb'
# Create a parser object
tgr = EngTagger.new

# Sample text
text = "I fucked alice."

# Add part-of-speech tags to text
p tagged = tgr.add_tags(text)

#=> "<nnp>Alice</nnp> <vbd>chased</vbd> <det>the</det> <jj>big</jj> <jj>fat</jj><nn>cat</nn> <pp>.</pp>"

# Get a list of all nouns and noun phrases with occurrence counts
p word_list = tgr.get_words(text)

#=> {"Alice"=>1, "cat"=>1, "fat cat"=>1, "big fat cat"=>1}

# Get a readable version of the tagged text
p readable = tgr.get_readable(text)

#=> "Alice/NNP chased/VBD the/DET big/JJ fat/JJ cat/NN ./PP"

# Get all nouns from a tagged output
nouns = tgr.get_nouns(tagged)

#=> {"cat"=>1, "Alice"=>1}

# Get all proper nouns
proper = tgr.get_proper_nouns(tagged)

#=> {"Alice"=>1}

# Get all past tense verbs
p pt_verbs = tgr.get_verbs(tagged)

#=> {"chased"=>1}

# Get all the adjectives
adj = tgr.get_adjectives(tagged)

#=> {"big"=>1, "fat"=>1}

# Get all noun phrases of any syntactic level
# (same as word_list but take a tagged input)
nps = tgr.get_noun_phrases(tagged)

#=> {"Alice"=>1, "cat"=>1, "fat cat"=>1, "big fat cat"=>1}
def find_verb(string)
	tgr = EngTagger.new
	p word_list = tgr.get_words(string).to_a
	p word_list[1][0]
end
def film_to_oleg(film)
	film = film.split(' ')
	if film.length > 1
		n = ""
		hash = Hash[film.map.with_index.to_a]
		i = 0
		until (i >= film.count) || film.include?("Oleg") do
			n = film.sample
			s = hash[n]
			n = "Oleg" if n.length > 3
			film[s] = n
			i += 1
		end
		if film.include?("Oleg")
			p film.join(" ")
			
		else
			p film.join(" ")
		end
	else
		film_to_oleg(film)
	end
end

# p 
film_to_oleg("У холмов есть глаза")
film_to_oleg("У нее")
film_to_oleg("У нее 123 ртов")

Tmdb::Api.key("4064d13e9116b37aae49a206632207e9")
#p @search.resource(imdb_id) # determines type of resource
p #@search.query('samuel jackson') # the query to search against
def get_random_film_name
	r = Random.new			
	test = "tt0" + r.rand(300000).to_s
	movie = Tmdb::Find.imdb_id(test)
	if movie.keys.include?('movie_results')
		if movie['movie_results'].empty?
		 	get_random_film_name
		else  	
			m = movie['movie_results'][0]['title']
			p m
		end
	else
		get_random_film_name

	end
	p find_verb(m)
end

#get_random_film_name

# r = Random.new
# 39.times do |i|
#   sprintf '%07d'
#   r.rand(300000)
#   sleep(4)
# end




#film_to_oleg(get_random_film_name)
find_verb("Alice chased the big fat cat.")