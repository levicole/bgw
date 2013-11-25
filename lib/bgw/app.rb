module Bgw

  require 'sinatra/base'
  require 'json'

  class App < Sinatra::Base
    set :root,          File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, "app/public") }
    set :views,         Proc.new { File.join(root, "app/views") }
    set :commits_per_page, 50

    get "/" do
      @title = repo.workdir.split("/").last
      erb :index
    end

    get "/branches.json", provides: "application/json" do
      Bgw::Models::BranchList.new(repo).to_json
    end

    get "/commits.json", provides: "application/json" do
      offset  = params[:offset] || "HEAD"
      perpage = params[:perpage].to_i || settings.commits_per_page
      Bgw::Models::CommitList.new(repo, offset).to_json
    end

    get "/commit/:oid", provides: "application/json" do
      commit = Bgw.repo.lookup(params[:oid])
      parent = commit.parents.first
      diff = parent.diff(commit)
      patches = diff.collect do |patch|
        filename = patch.delta.old_file[:path]
        hunks = patch.collect do |hunk|
          header = hunk.header
          lines = hunk.collect do |line|
            old_lineno = line.old_lineno > 0 ? line.old_lineno : ""
            new_lineno = line.new_lineno > 0 ? line.new_lineno : ""
            {line_origin: line.line_origin, content: line.content, old_lineno: old_lineno, new_lineno: new_lineno}
          end
          {header: header, lines: lines}
        end
        {filename: filename, hunks: hunks}
      end.to_json
    end

    def repo
      Bgw.repo
    end
  end
end
