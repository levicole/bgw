require 'sinatra'
require 'rugged'


require 'bgw/models/branch'
require 'bgw/models/branch_list'
require 'bgw/app'

module Bgw
  extend self

  def repo=(repo)
    @repo ||= Rugged::Repository.new(repo)
  end

  def repo
    @repo
  end
end
