module Bgw
  module Models
    class CommitList
      def initialize(repo, offset)
        @repo = repo
        @offset = offset
      end

      def commits
        @commits ||= @repo.walk(@offset).collect { |c| Bgw::Models::Commit.new(c) }
      end

      def to_json
        commits.to_json
      end
    end
  end
end
