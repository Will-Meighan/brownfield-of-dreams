# frozen_string_literal: true

require 'rails_helper'

describe Repository do
  it 'exists' do
    attrs = {
      name: 'Brownfield',
      html_url: 'https://brownfield.com'
    }

    repo = Repository.new(attrs)

    expect(repo).to be_a Repository

    expect(repo.name).to eq('Brownfield')
    expect(repo.url).to eq('https://brownfield.com')
  end
end
