require "rails_helper"

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
  let!(:member) { create(:member) }
  let!(:wife_member) { create(:member, partner: member) }
  let!(:child) { create(:member) }
  let!(:another_child) { create(:member) }
  let!(:child_of_child) { create(:member) }
  let!(:connection) { create(:connection, procreator: member, baby: child)}
  let!(:another_connection) { create(:connection, procreator: child, baby: child_of_child)}
  let!(:connection2) { create(:connection, procreator: member, baby: another_child)}

  # it "return unordered list with all members" do
  #   html = "<ul><li><a href=\"#{member_path(member)}\">#{member.full_name}</a>\n<ul><li><a href=\"#{member_path(child)}\">#{child.full_name}</a>\n<ul><li><a href=\"#{member_path(child_of_child)}\">#{child_of_child.full_name}</a>\n</li></ul></li><li><a href=\"#{member_path(another_child)}\">#{another_child.full_name}</a>\n</li></ul></li></ul>"
  #   expect(tree(member.subtree.arrange)).to eq(html)
  # end
end
