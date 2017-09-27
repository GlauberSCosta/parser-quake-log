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

	def add_deaths
		@deaths+=1
	end

	def update_kills_by_means(mean)
		begin
			raise ParserQuakeException::MustBeString, "<mean> Precisa ser uma String" if mean.class!=String
			raise ParserQuakeException::BlankString, '<mean> Precisa preencher o tipo de execucao' if mean.gsub(/\s/,'').empty?
			@kills_by_means[mean] ? @kills_by_means[mean]+=1 : @kills_by_means[mean]=1
		rescue ParserQuakeException::MustBeString
			raise
		rescue ParserQuakeException::BlankString
			raise
		end
	
	end
	
	def update_deaths_by_means(mean)
		begin
			raise ParserQuakeException::MustBeString, "<mean> Precisa ser uma String" if mean.class!=String
			raise ParserQuakeException::BlankString, '<mean> Precisa preencher o tipo de morte' if mean.gsub(/\s/,'').empty?
			@deaths_by_means[mean] ? @deaths_by_means[mean]+=1 : @deaths_by_means[mean]=1
		rescue ParserQuakeException::MustBeString
			raise
		rescue ParserQuakeException::BlankString
			raise
		end	
	end

end