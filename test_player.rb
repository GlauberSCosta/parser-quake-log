class TestPlayer < Test::Unit::TestCase
	

	def test_initialize
		assert_raise(ArgumentError){Player.new}
		assert_raise(ParserQuakeLogException::MustBeString){Player.new 1}
		assert_raise(ParserQuakeLogException::BlankString){Player.new ""}
	end

	def test_get_name		
		p = Player.new "glauber_costa"
		assert_equal("glauber_costa", p.name)		
	end

	def test_get_and_add_deaths
		p=Player.new "glauber_costa"
		assert_equal(0,p.deaths)
		p.add_deaths
		assert_equal(1,p.deaths)
		p.add_deaths
		assert_equal(2,p.deaths)
		p.add_deaths
		assert_equal(3,p.deaths)	
	end

	def test_get_and_set_kill_by_means
		p=Player.new "glauber_costa"
		assert_equal({},p.kills_by_means)
		p.update_kills_by_means("bereta")
		assert_equal({"bereta" => 1}, p.kills_by_means)
		p.update_kills_by_means("desert")
		assert_equal({"desert" => 1, "bereta"=>1}, p.kills_by_means)
		assert_equal({"bereta"=>1, "desert" => 1}, p.kills_by_means)
		p.update_kills_by_means("desert")
		assert_equal({"desert"=>2, "bereta" => 1}, p.kills_by_means)
	end

	def test_get_and_set_deaths_by_means
		p=Player.new "glauber_costa"
		assert_equal({},p.deaths_by_means)
		p.update_deaths_by_means("bereta")
		assert_equal({"bereta" => 1}, p.deaths_by_means)
		p.update_deaths_by_means("shotgun")
		assert_equal({"shotgun" => 1, "bereta"=>1}, p.deaths_by_means)
		assert_equal({"bereta"=>1, "shotgun" => 1}, p.deaths_by_means)
		p.update_deaths_by_means("bereta")
		assert_equal({"bereta"=>2, "shotgun" => 1}, p.deaths_by_means)
	end

	def test_get_hash_player
		player=Player.new "glauber_costa"
		player.add_kills
		player.add_deaths
		player.update_kills_by_means("bereta")
		player.update_deaths_by_means("teste morte")
		player.update_penalty_by_means("teste morte")
		assert_equal(
		{:name => "glauber_costa",
		 :kills => 1,
		 :deaths => 1,
		 :kills_by_means =>{"bereta" => 1},
		 :deaths_by_means => {"teste morte" => 1},
		 :penalty_by_means => {"teste morte" => 1}}, player.to_hash)				
	end


	def test_get_and_set_penalty
		p = Player.new "glauber_costa"
		assert_equal({}, p.penalty_by_means)
		assert_equal(0, p.number_of_penalties)
		p.update_penalty_by_means("teste morte")
		assert_equal({"teste morte" => 1}, p.penalty_by_means)
		p.update_penalty_by_means("queda")
		assert_equal({"teste morte" => 1,"queda" => 1}, p.penalty_by_means)
		p.update_penalty_by_means("queda")
		assert_equal({"teste morte" => 1,"queda" => 2}, p.penalty_by_means)
		assert_equal(3, p.number_of_penalties)		
	end
end