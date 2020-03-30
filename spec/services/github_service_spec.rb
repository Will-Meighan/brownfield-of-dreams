require 'rails_helper'

describe 'Github Service' do
  it 'can show repositories' do
    user1 = create(:user, token: ENV['GITHUB_API_KEY'])
  end

  it 'can show followers' do
  end

  it 'can show following' do
  end
end
