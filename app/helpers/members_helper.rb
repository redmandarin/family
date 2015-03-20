module MembersHelper
  def tree(member)
    ar = []
    ar << member

    "<ul><a href='#{member_path(member)}'>#{member.full_name}</a>" 
    # render("members/member")
  end
end
