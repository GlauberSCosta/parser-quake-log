require File.expand_path('game')
require File.expand_path('parser_quake_log_errors_class')
require File.expand_path('player')

class Array
    def sum
        self.inject{|sum,x| sum + x }
    end
end

class ParserQuakeLog

	@@means_of_death = [
		'MOD_RAILGUN',
		'MOD_UNKNOWN',
		'MOD_SHOTGUN',
		'MOD_GAUNTLET',
		'MOD_MACHINEGUN',
		'MOD_GRENADE',
		'MOD_GRENADE_SPLASH',
		'MOD_ROCKET',
		'MOD_ROCKET_SPLASH',
		'MOD_PLASMA',
		'MOD_PLASMA_SPLASH',
		'MOD_RAILGUN',
		'MOD_LIGHTNING',
		'MOD_BFG',
		'MOD_BFG_SPLASH',
		'MOD_WATER',
		'MOD_SLIME',
		'MOD_LAVA',
		'MOD_CRUSH',
		'MOD_TELEFRAG',
		'MOD_FALLING',
		'MOD_SUICIDE',
		'MOD_TARGET_LASER',
		'MOD_TRIGGER_HURT',
		'MOD_NAIL',
		'MOD_CHAINGUN',
		'MOD_PROXIMITY_MINE',
		'MOD_KAMIKAZE',
		'MOD_JUICED',
		'MOD_GRAPPLE'
		]
	
	
	def initialize(path)
		string = File.open(path, 'rb') { |file| file.read}
		
		@games = Array.new
		@cont = 0
		string.each_line do |line| 
			if start_game?(line)
				#registrar uma nova partida partida
				
				@games << Game.new(@cont)
				@cont+=1

			elsif player_info?(line)
				player = Player.new(get_player_info(line))
				@games.last.add_player(player)

			elsif kill?(line)
				#obter informacoes de uma morte
				# quem matou
				# vitima
				# causa da morte

				mean = get_cause_of_death(line)
				killer = get_killer(line)
				victim = get_victim(line)
				
				@games.last.add_kill

				

				if killer != "<world>"
					player1 = @games.last.player(killer)
					player1.add_kills
					player1.update_kills_by_means(mean)
					
				end
				player2 = @games.last.player(victim)
				player2.add_deaths
				player2.update_deaths_by_means(mean)
				
			end
		end		
	end
	


	def games
		@games
	end
#-------
	def start_game?(line)
		line=~/^\s{1,2}\d{1,2}:\d{2} InitGame:/ ? true : false
		
	end
	
	def kill?(line)
		line=~/^ (\d:\d\d|\d\d:\d\d) Kill:/ ? true : false
	end

	def player_info?(line)
		line=~/^(\s\d{2}|\s\s\d):\d{2} ClientUserinfoChanged:/ ? true : false	
	end

	def get_player_info(line)
		line.match(/n\\.+\\t\\\d/).to_s.gsub(/n\\|\\t\\\d/,'')
	end
	
	def get_death(line)
		line.match(/(#{@@means_of_death.join('|')})$/).to_s
	end

	def get_victim(line)
		line.match(/(#{(@games.last.players_names << '<world>').join('|')}) by/).to_s.gsub!(/ by$/,'')
	end

	def get_cause_of_death(line)
		line.strip.match(/(#{@@means_of_death.join('| ')})$/).to_s
	end
	
	def get_killer(line)
		line.match(/(#{(@games.last.players_names << '<world>').join('|')}) killed/).to_s.gsub!(/ killed$/,'')
	end
end


