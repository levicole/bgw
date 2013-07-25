require 'test_helper'

module Bgw
  module Models
    class BranchTest < Minitest::Unit::TestCase

      def setup
        fake_rugged_branch = FakeRuggedBranch.new("the_branch", false, true)
        @branch = Branch.new(fake_rugged_branch)
      end

      def test_branch_name
        assert_equal @branch.name, "the_branch"
      end

      def test_branch_remote
        assert_equal @branch.remote?, false
      end

      def test_branch_head
        assert_equal @branch.head?, true
      end

      def test_to_json
        assert_equal @branch.to_json, {name: "the_branch", remote: false, head: true}.to_json
      end
    end
  end
end
