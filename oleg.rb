require 'rubygems'
require 'movieDB/base.rb'
require 'engtagger'
require 'themoviedb'


Tmdb::Api.key("4064d13e9116b37aae49a206632207e9")
Tmdb::Api.language("en")

# Формирует из заданной строки массив со всеми глаголами (англ)
def find_verbs(string)
	# Подключаем таггер, массив цензуры, и правильный массив цензуры
	tgr = EngTagger.new
	censure = []
	right_censure = []
	i = 0
	# помечаем все слова и знаки тэгами
	word_list = tgr.add_tags(string)
	
	# Здесь идет поиск всех возможных вариаций глаголов 
	i_verbs 	= tgr.get_infinitive_verbs(word_list).to_a
	pt_verbs 	= tgr.get_past_tense_verbs(word_list).to_a
	g_verbs 	= tgr.get_gerund_verbs(word_list).to_a
	bp_verbs 	= tgr.get_base_present_verbs(word_list).to_a
	p_verbs 	= tgr.get_passive_verbs(word_list).to_a
	pr_verbs 	= tgr.get_present_verbs(word_list).to_a
	
	censure = i_verbs + pt_verbs + g_verbs + bp_verbs + p_verbs + pr_verbs
	
	
	until i >= censure.length
		right_censure.push(censure[i][0])
		i += 1
	end
	right_censure
end

# Проверка на то, является ли данное слово глаголом в данной строке
def is_a_verb?(word, string)
	find_verbs(string).include?(word)
end

# Вовзращает преобразованную строку из символов
def film_to_oleg(film)
	film = film.split(' ')
	if film.length > 1 && (!film.include?("The"))
		n = ""
		hash = Hash[film.map.with_index.to_a]
		i = 0
		until (i >= (film.count * 3)) || film.include?("Oleg") do
			n = film.sample
			s = hash[n]
			if n.length > 3 && !is_a_verb?(n, film.join(' ')) && /[0-9]/.match(n).nil?
				n = "Oleg"
			end
			film[s] = n
			i += 1
		end
		if film.include?("Oleg")
			film.join(" ")
		else
			@film = get_random_film_name
			@film = get_valid_film_name(@film)
			film_to_oleg(@film)
		end
	else
		new_film = get_valid_film_name(get_random_film_name)
		film_to_oleg(new_film)
	end
end

# p 



#p @search.resource(imdb_id) # determines type of resource
p #@search.query('samuel jackson') # the query to search against
def get_random_film_name
	r = Random.new			
	test = "tt" + r.rand(3000000).to_s
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
	#p find_verbs(m)
end

#get_random_film_name

# r = Random.new
# 39.times do |i|
#   sprintf '%07d'
#   r.rand(300000)
#   sleep(4)
# end
#film_to_oleg("The hills have eyes")
#film_to_oleg("У нее")
#film_to_oleg("У нее 123 ртов")


#t = Time.now
##film_to_oleg(get_random_film_name)
##find_verbs("Alice chased and take take takes took taking the big fat cat.")
#T = Time.now
#p is_a_verb?("take", "Alice chased and take take takes took taking the big fat cat.")
#p TN = Time.now - T


def match_numbers(str)
	!/[0-9]/.match(str).nil?	
end

def get_valid_film_name(film)
	tgr = EngTagger.new
	valid_words = tgr.add_tags(film)
	valid_words_1 = tgr.get_nouns(valid_words)
	if !valid_words_1.nil?
		film
	else
		film = get_random_film_name
		get_valid_film_name(film)
	end
	#film = "1942 abc zxcac"

end

#p match_numbers("1942 abc zxc")
#
#p film_to_oleg("1942 abc zxcac")
#
#p get_valid_film_name(get_random_film_name)

p film_to_oleg(get_valid_film_name(get_random_film_name))
