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
		
		string.each_line do |line| 
			
			if start_game?(line)
				#registrar uma nova partida partida
								
			elsif player_info?(line)
				#identificar um jogador
			elsif kill?(line)
				#obter informacoes de uma morte
				# quem matou
				# vitima
				# causa da morte
			end
		end		
	end
	
	


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
	
end


