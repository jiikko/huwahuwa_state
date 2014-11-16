require 'spec_helper'

describe HuwahuwaState::Main do
  context '正しい遷移する時' do
    it "pendingからactiveに遷移すること" do
      user = User.create(state: User.states["state_pending"])
      user.update_state!(:state_active)
      expect(user.state).to eq('state_active')
    end

    it "activeからlockへ遷移すること" do
      user = User.create(state: User.states["state_active"])
      user.update_state!(:state_rock)
      expect(user.state).to eq('state_rock')
    end
  end

  context '想定していない遷移をする時' do
    it "catch exception" do
      user = User.create(state: User.states["state_active"])
      expect {
        user.update_state!(:state_pending)
      }.to raise_error(HuwahuwaState::NotAcceptedUpdate)
    end
  end
end
