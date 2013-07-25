require 'test_helper'

class BranchListTest < Minitest::Unit::TestCase
  class FakeRepo
    def branches
      [FakeRuggedBranch.new("foo", false, false), FakeRuggedBranch.new("bar", true, true)]
    end
  end

  def setup
    fake_repo = FakeRepo.new
    @branch_list = Bgw::Models::BranchList.new(fake_repo)
  end

  def test_branches
    refute @branch_list.branches.to_a.empty?, "branch list shouldn't be empty"
  end

  def test_branches_is_enum
    assert_kind_of Enumerator, @branch_list.branches
  end

  def test_branches_kind
    @branch_list.branches.each do |branch|
      assert_kind_of Bgw::Models::Branch, branch
    end
  end

  def test_to_json
    expected_json = [{name: "foo", remote: false, head: false}, {name: "bar", remote: true, head: true}]
    assert_equal @branch_list.to_json, expected_json.to_json
  end
end
