# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  context 'instance methods' do
    context '#get_reops' do
      it 'returns user repos' do
        repo_fixture = File.read('spec/fixtures/repo.json')

        stub_request(:get, 'https://api.github.com/user/repos?page=1&per_page=5&affiliation=owner').to_return(status: 200, body: repo_fixture)

        github_service = GithubService.new(ENV['GITHUB_TEST_TOKEN_2'])
        repos = github_service.get_repos

        expect(repos).to be_a Array
        expect(repos.count).to eq 1

        repo = repos.first

        expect(repo).to have_key :name
        expect(repo).to have_key :html_url
      end
    end
  end
end
