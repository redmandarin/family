require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MembersHelper. For example:
#
# describe MembersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MembersHelper, type: :helper do
  let(:member) { create(:member) }
  let(:wife_member) { create(:member, partner: member) }
  let(:child) { create(:member) }
  let(:child_of_child) { create(:member) }
  let(:connection) { create(:connection, parent: member, child: child)}
  let(:another_connection) { create(:connection, parent: child, child: child_of_child)}

  it 'return unordered list with all members' do
    another_connection
    html = "<ul><li><a href='#{member_path(member)}'>#{member.full_name}</a><ul><li><a href='#{member_path(child)}'>#{child.full_name}</a><ul><li><a href='#{member_path(child_of_child)}'>#{child_of_child.full_name}</a></li></ul></li></ul></li></ul>"
    expect(tree(member)).to eq(html)
  end
end
