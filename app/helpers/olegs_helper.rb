module OlegsHelper
	@answer = ""
	# Вовзращает преобразованную строку из символов
	def film_to_oleg(film)
		p @answer = film
		film = film.split(' ')
		if film.length > 1 && (!film.include?("The"))
			n = ""
			hash = Hash[film.map.with_index.to_a]
			i = 0
			until (i >= (film.count)) ||
				  film.include?("Oleg") ||
				  film.include?("Olegs") do
				n = film.sample
				s = hash[n]
				if n.length > 3 && !is_a_verb?(n, film.join(' ')) && /[0-9]/.match(n).nil?
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
				@film = get_random_film_name
				@film = get_valid_film_name(@film)
				film_to_oleg(@film)
			end
		else
			new_film = get_valid_film_name(get_random_film_name)
			film_to_oleg(new_film)
		end
	end

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
	end

	def test_singularity(str)
  	str.pluralize != str && str.singularize == str
	end
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

end
