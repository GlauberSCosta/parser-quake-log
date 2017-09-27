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
    		     "}"
    	end

end