require 'forwardable'
module Bgw
  module Models
    class Branch
      extend Forwardable

      def_delegators :@rugged_branch, :name, :remote?, :head?

      def initialize(rugged_branch)
        @rugged_branch = rugged_branch
      end

      def to_json(state=nil)
        {name: name, remote: remote?, head: head? }.to_json
      end
    end
  end
end
