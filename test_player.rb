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
end