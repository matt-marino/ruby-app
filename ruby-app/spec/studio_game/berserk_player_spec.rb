require "studio_game/berserk_player"

module StudioGame
  describe BerserkPlayer do
    before do
      @initial_health = 50
      @player = BerserkPlayer.new("berserker", @initial_health)
      $stdout = StringIO.new
    end

    it "does not go berserk when w00ted up to 5 times" do
      1.upto(5) { @player.w00t }

      expect(@player.berserk?).to be_falsey

      # or if using Rspec 3.0:
      # @player.berserk?.should be_falsey
    end

    it "goes berserk when w00ted more than 5 times" do
      1.upto(6) { @player.w00t }

      expect(@player.berserk?).to be_truthy

      # or if using Rspec 3.0:
      # @player.berserk?.should be_truthy
    end

    it "gets w00ted instead of blammed when it's gone berserk" do
      1.upto(6) { @player.w00t }
      1.upto(2) { @player.blam }

      expect(@player.health).to eq(@initial_health + (8 * 15))
    end
  end
end
