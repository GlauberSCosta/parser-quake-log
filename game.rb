class Game	
	
    	

	def initialize(id)
		begin
			raise ParserQuakeLogException::MustBeNumber, "<id> Precisa ser número Inteiro" if id.class != Fixnum
			@id = id
			@total_kills = 0
			@players = Hash.new

		rescue ParserQuakeLogException::MustBeNumber
			raise
		end
	end

	def total_kills
		@total_kills    	
	end    

	def players
		@players
	end
end