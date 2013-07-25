module Bgw
  module Models
    class BranchList
      def initialize(repo)
        @repo = repo
      end

      def branches
        @branches ||= @repo.branches.collect { |b| Bgw::Models::Branch.new(b) }.to_enum
      end

      def to_json
        branches.to_a.to_json
      end
    end
  end
end
