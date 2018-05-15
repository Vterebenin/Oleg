require 'rubygems'
require 'movieDB/base.rb'
require 'engtagger'
require 'themoviedb'

#require 'ruby-tmdb'


Tmdb::Api.key("4064d13e9116b37aae49a206632207e9")
Tmdb::Api.language("en")
#Tmdb.api_key = "4064d13e9116b37aae49a206632207e9"
#Tmdb.default_language = "en"

# Формирует из заданной строки массив со всеми существительными (англ)
def find_nouns(string)
	# Подключаем таггер, массив цензуры, и правильный массив цензуры
	tgr = EngTagger.new
	#p tgr.methods - Object.methods
	right_censure = []
	i = 0
	# помечаем все слова и знаки тэгами
	word_list = tgr.add_tags(string)
	
	# Поиск всех существительных 
	nouns 	= tgr.get_words(word_list).to_a
	
	until i >= nouns.length
		right_censure.push(nouns[i][0])
		i += 1
	end
	right_censure
end

# Проверка на то, является ли данное слово глаголом в данной строке
def is_a_noun?(word, string)
	find_nouns(string).include?(word)
end

# Вовзращает преобразованную строку из символов
def film_to_oleg(film)
	film = film.split(' ')
	#if film.length > 1 && (!film.include?("The"))
	n = ""
	hash = Hash[film.map.with_index.to_a]
	i = 0
	until (i >= (film.count * 3)) || film.include?("Oleg") do
		n = film.sample
		s = hash[n]
		if n.length > 3 && is_a_noun?(n, film.join(' ')) && /[0-9]/.match(n).nil?
			n = "Oleg"
		end
		film[s] = n
		i += 1
	end
	if film.include?("Oleg")
		film.join(" ")
	else
		film_to_oleg(film)
	end
	#else
	#	new_film = get_valid_film_name(get_random_film_name)
	#	film_to_oleg(new_film)
	#end
end

# p 



#p @search.resource(imdb_id) # determines type of resource
p #@search.query('samuel jackson') # the query to search against
def get_random_film_name		
	random_imdb_id = "tt0" + Random.rand(300000).to_s
	movie = Tmdb::Find.imdb_id(random_imdb_id)
	if movie.keys.include?('movie_results') && !movie['movie_results'].empty?
		m = movie['movie_results'][0]['title'] 
		if !(m.include?("The")) && m.length > 1
			m
		else
			get_random_film_name
		end
	else
		get_random_film_name
	end
end



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
T = Time.now

p film_to_oleg(get_random_film_name)
p TN = Time.now - T


#p film_to_oleg(get_valid_film_name(get_random_film_name))



#p find_nouns("Alice chased egors find rhino and take take takes took taking the big fat cat.")