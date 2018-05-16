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
			
			film_to_oleg(film.join(' '))
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
		if movie.keys.include?('movie_results') &&  # не пустой результат существует
			 			 !movie['movie_results'].empty? && # есть фильмы
			  			movie['movie_results'][0]['original_language'] == "en" # и оригинальный язык названия английский
			m = movie['movie_results'][0]['title'].split(' ') 
			if (m.include?("The") && m.length == 2) || m.length == 1 || find_nouns(m.join(' ')).nil?
				get_random_film_name
			else
				m.join(' ')
			end

		else
			get_random_film_name
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
		good_message = ["Okay, you win.. for now.", "You are right!",
		"It was too easy, isnt it?"]
		good_message[Random.rand(good_message.length)]
	end

	def bad_notice
		bad_message = ["Nah, wrong.. for now.", 
				 "You are right! ... JK!",
					"Are you even trying?"]
		bad_message[Random.rand(bad_message.length)]
	end

	def show_film
		movie = Tmdb::Movie.find(@oleg.answer)
	end

end
