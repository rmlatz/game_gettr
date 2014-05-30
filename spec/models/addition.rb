require 'spec_helper'

describe Addition do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:game_id) }
end
