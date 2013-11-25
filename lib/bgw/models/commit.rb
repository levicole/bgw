require 'forwardable'
module Bgw
  module Models
    class Commit
      extend Forwardable

      def_delegators :@rugged_commit, :oid, :message

      def initialize(rugged_commit)
        @rugged_commit = rugged_commit
      end

      def to_json(state=nil)
        { sha: oid, message: message }.to_json
      end
    end
  end
end
