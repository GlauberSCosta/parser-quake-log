class Game	
	
    	

	def initialize(id)
		begin
			raise ParserQuakeLogException::MustBeInteger, "<id> Precisa ser número Inteiro" if id.class != Fixnum
			@id = id
			@total_kills = 0
			@players = Hash.new

		rescue ParserQuakeLogException::MustBeInteger
			raise
		end
	end

	def total_kills
		@total_kills    	
	end    

	def players
		@players
	end

	def add_player(player)
		begin
			raise ArgumentError,"<player> não pode ser nil" if player.nil?			
			raise ParserQuakeLogException::PlayerMustBeUnique, "Nome de jogador existente na partida " if player?(player.name)
    			@players.merge!({player.name => player})
		rescue ArgumentError
			raise
		rescue ParserQuakeLogException::PlayerMustBeUnique
			#possível reconexão
		end
    end

	def player?(player_name)
		@players[player_name] ? true : false
	end

	def to_s
		deaths_by_means = Hash.new
		@players.each_pair do |k,p|
			deaths_by_means.merge!(p.deaths_by_means){|k,v1,v2| v1+v2}
		end

		"game_#{@id}:\n"+
    		     "{"+
    		     	"\ttotal_kills: #{@total_kills}\n"+
    		     	"\tplayers:\n"+
    		     	"\t{\n"+
    		     		@players.map{|n,p| "\t\t#{n}"}.join(",\n")+
    		     	"\n\t}\n"+
    		     	"\tkills:\n"+
    		     	"\t{\n"+
    		     		@players.map{|n,p| "\t\t#{n}: #{p.kills} #{p.penalities? ? p.penalities_to_s : ''}"}.join("\n")+
    		     	"\n\t}\n"+
			"\tdeaths_by_means:\n"+
    		     	"\t{\n"+
    		     		deaths_by_means.map{|n,p| "\t\t#{n}: #{p}"}.join("\n")+
    		     	"\n\t}\n"+  
    		     "}"
    end

    def player(player_name)
		begin
			raise ParserQuakeLogException::PlayerNotExists, "<#{player_name}> Jogador nao faz parte da partida" if !player?(player_name) 
		@players[player_name]
		rescue ParserQuakeLogException::PlayerNotExists
			raise
		end
	end
    
    def players_names
		@players.keys.sort
	end

	def add_kill
    	@total_kills+=1
    end
   
    def add_kills(player_name)
		self.player(player_name).add_kills
	end 	
	
	def add_deaths(player_name)
		self.player(player_name).add_deaths
	end
	
	def subtract_kills(player_name)
		self.player(player_name).subtract_kills
	end
	
	def update_kills_by_means(player_name, mean)
		self.player(player_name).update_kills_by_means(mean)
	end
	
	def update_deaths_by_means(player_name, mean)
		self.player(player_name).update_deaths_by_means(mean)
	end 
end