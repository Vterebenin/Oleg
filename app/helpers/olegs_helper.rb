module OlegsHelper
	@answer = ""
	# Вовзращает преобразованную строку из символов
	def film_to_oleg(film)
		p @answer = film # D E B U G !!!!
		p $answer = film
		film = film.split(' ') # раскладываем фильм на слова
		# Если фильм не состоит из двух слов с The и если его длина больше 1
		n = ""
		hash = Hash[film.map.with_index.to_a]
		i = 0
		until (i >= (film.count)) ||
			  film.include?("Oleg") ||
			  film.include?("Olegs") do
			n = film.sample
			s = hash[n]
			if n.length > 3 && is_a_noun?(n, film.join(' ')) && /[0-9]/.match(n).nil?
				if test_singularity(n)
					n = "Oleg"
				else
					n = "Olegs"
				end
			end
			film[s] = n
			i += 1
		end
		if film.include?("Oleg") || film.include?("Olegs")
			film.join(" ")
		else
			@film = @answer
			film_to_oleg(@film)
		end
	end

	def get_random_film_name1
		r = Random.new	
		# Ищем случайный фильм с imdb		
		random_imdb_id = "tt0" + Random.rand(300000).to_s
		movie = Tmdb::Find.imdb_id(random_imdb_id)

		# обрабатываем хэш, полученный с imdb
		if movie.keys.include?('movie_results') && !movie['movie_results'].empty?
			# если результаты по фильмам не пустые
			# вывести хэш тайтла
		 	m = movie['movie_results'][0]['title']
		else # если результаты айди по фильмам пустые
			# рекурсия
			get_random_film_name
		end
	end

	def get_random_film_name		
		random_imdb_id = "tt0" + Random.rand(300000).to_s
		movie = Tmdb::Find.imdb_id(random_imdb_id)
		if movie.keys.include?('movie_results') && !movie['movie_results'].empty?
			m = movie['movie_results'][0]['title'] 
			if ((m.include?("The")) && m.length == 2) && m.length > 1
				m
			else
				get_random_film_name
			end
		else
			get_random_film_name
		end
	end

	# искать фильмы пока не найдется хотя бы одно валидное имя
	def get_valid_film_name(film)
		tgr = EngTagger.new
		tagged = tgr.add_tags(film)
		valid_words = tgr.get_nouns(tagged)

		# если есть существительные
		if !valid_words.nil?
			# проходит проверку
			film 
		else # зацикливаем пока не найдем валидный фильм
			film = get_random_film_name
			get_valid_film_name(film)
		end
	end

	# протестировать на сингулярность(множественное число будет false)
	def test_singularity(str)
  	str.pluralize != str && str.singularize == str
	end
	
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

	def good_notice
		r = Random.new
		a = ["Okay, you win.. for now.", "You are right!",
		"It was too easy, isnt it?"]
		a[r.rand(a.length)]
	end

	def bad_notice
		r = Random.new
		a = ["Nah, wrong.. for now.", "You are right! ... JK!",
		"Are you even trying?"]
		a[r.rand(a.length)]
	end

end
