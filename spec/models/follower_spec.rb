require 'rails_helper'

RSpec.describe Follower, type: :model do
  it 'has attributes' do
    handle = 'kathleen-carroll'
    url = 'https://github.com/kathleen-carroll'
    id = 5940848
    info = {login: handle, html_url: url, id: id}

    follower = Follower.new(info)

    expect(follower.handle).to eq(handle)
  end
end
