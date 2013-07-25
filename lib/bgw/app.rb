module Bgw

  require 'sinatra/base'
  require 'json'

  class App < Sinatra::Base
    set :root,          File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, "app/public") }
    set :views,         Proc.new { File.join(root, "app/views") }
    set :commits_per_page, 50

    helpers do
    end

    get "/" do
      @title = repo.workdir.split("/").last
      @branches = Bgw::Models::BranchList.new(repo)
      erb :index
    end

    get "/branches.json", provides: "application/json" do
      Bgw::Models::BranchList.new(repo).to_json
    end

    get "/commits.json", provides: "application/json" do
      offset  = params[:offset] || "HEAD"
      perpage = params[:perpage].to_i || settings.commits_per_page
      repo.walk(offset).collect { |c| { sha: c.oid, message: c.message } }.to_json
      Bgw::Models::CommitList.new(repo, offset, perpage).to_json
    end

    def repo
      Bgw.repo
    end
  end

end
