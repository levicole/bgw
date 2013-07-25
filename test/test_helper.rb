require 'bgw'
require 'minitest/unit'
require 'minitest/autorun'
require 'purdytest'

FakeRuggedBranch = Struct.new(:name, :remote?, :head?)
