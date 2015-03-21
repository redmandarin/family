module MembersHelper
  def tree(members)
    members.map do |member, sub_members|
      content_tag(:ul) do
        content_tag(:li, render(member) + tree(sub_members))
      end
    end.join.html_safe
  end
end
