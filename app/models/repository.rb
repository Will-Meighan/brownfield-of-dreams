# frozen_string_literal: true

class Repository
  attr_reader :name, :url

  def initialize(info)
    @name = info[:name]
    @url = info[:html_url]
  end
end
