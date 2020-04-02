# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Following, type: :model do
  it 'has attributes' do
    handle = 'kathleen-carroll'
    url = 'https://github.com/kathleen-carroll'
    id = 5_940_848
    info = { login: handle, html_url: url, id: id }

    following = Following.new(info)

    expect(following.handle).to eq(handle)
  end
end
