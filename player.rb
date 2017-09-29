class Player	
	
	def initialize(name)
		begin
			raise ParserQuakeLogException::MustBeString, '<name>Valor não é uma String' if name.class!=String		
		
			raise ParserQuakeLogException::BlankString, '<name>String vazia' if name.gsub(/\s/,'').empty?

			@kills=0
			@name = name
			@deaths=0
			@kills_by_means = Hash.new
			@deaths_by_means = Hash.new
			@penalty_by_means = Hash.new
		
		rescue ParserQuakeLogException::MustBeString => e
			raise
		rescue ParserQuakeLogException::BlankString => e
			raise
		end	

	end	

	def name
		@name
	end

	def kills
		@kills
	end

	def deaths
		@deaths
	end
	
	def kills_by_means
		@kills_by_means
	end
	
	def deaths_by_means
		@deaths_by_means
	end

	def add_kills
		@kills+=1
	end	

	def add_deaths
		@deaths+=1
	end

	def subtract_kills
		@kills-=1
	end
	def update_kills_by_means(mean)
		begin
			raise ParserQuakeLogException::MustBeString, "<mean> Precisa ser uma String" if mean.class!=String
			raise ParserQuakeLogException::BlankString, '<mean> Precisa preencher o tipo de execucao' if mean.gsub(/\s/,'').empty?
			@kills_by_means[mean] ? @kills_by_means[mean]+=1 : @kills_by_means[mean]=1
		rescue ParserQuakeLogException::MustBeString
			raise
		rescue ParserQuakeLogException::BlankString
			raise
		end
	
	end
	
	def update_deaths_by_means(mean)
		begin
			raise ParserQuakeLogException::MustBeString, "<mean> Precisa ser uma String" if mean.class!=String
			raise ParserQuakeLogException::BlankString, '<mean> Precisa preencher o tipo de morte' if mean.gsub(/\s/,'').empty?
			@deaths_by_means[mean] ? @deaths_by_means[mean]+=1 : @deaths_by_means[mean]=1
		rescue ParserQuakeLogException::MustBeString
			raise
		rescue ParserQuakeLogException::BlankString
			raise
		end	
	end

	def to_s
		penalties_number = number_of_penalties
		
		 
		" Player: #{@name}"+
			"\n\tKills: #{@kills} #{if penalities? then penalities_to_s end}"+
			"\n\tDeaths: #{@deaths}"+
			"\n\tKills by means:"+
			"\n\t{\n"+
				@kills_by_means.map{|x,y| "\t\t#{x}: #{y}"}.join("\n")+
			"\n\t}\n"+
			"\n\tDeaths by means:"+
			"\n\t{\n"+
				@deaths_by_means.map{|x,y| "\t\t#{x}: #{y}"}.join("\n")+
			"\n\t}\n\n\n"
	end

	def to_hash
		{:name => @name,
		 :kills => @kills,
		 :deaths =>@deaths,
		 :kills_by_means =>@kills_by_means,
		 :deaths_by_means => @deaths_by_means,
		 :penalty_by_means => @penalty_by_means}
	end

	def update_penalty_by_means(mean)
		begin
			raise ParserQuakeLogException::MustBeString, "<mean> Precisa ser uma String" if mean.class!=String
			raise ParserQuakeLogException::BlankString, '<mean> Precisa estar preenchida' if mean.gsub(/\s/,'').empty?		
			@penalty_by_means[mean] ? @penalty_by_means[mean]+=1 : @penalty_by_means[mean]=1
		rescue ParserQuakeLogException::MustBeString
			raise
		rescue ParserQuakeLogException::BlankString
			raise
		end
	end
	def penalities?
		number_of_penalties > 0 ? true : false		
	end
	
	def penalities_to_s
		" (kills of penalty: #{number_of_penalties} by {#{hash_to_s(penalty_by_means)}})"		
	end

	def penalty_by_means
		@penalty_by_means
	end

	def number_of_penalties
		@penalty_by_means.size == 0 ? 0 : @penalty_by_means.values.sum

	end

	private
	def hash_to_s(hash)
		hash.map do |k,v|
			"#{k}: #{v}"		
		end.join(', ')		
	end
end 