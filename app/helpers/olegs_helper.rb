module OlegsHelper
	def film_to_oleg(film)
		film = film.split(' ')
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
			film.join(" ")
		else
			film.join(" ")
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
				if m.split(" ").length > 1
		 			m
		 		else
		 			get_random_film_name
				end
			end
		else
			get_random_film_name
		end
		
	end
	# 
end
