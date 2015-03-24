module MembersHelper
  def tree(members)
    content_tag(:ul) do
      members.map do |member, sub_members|
        content_tag(:li, render(member) + tree(sub_members))
      end.join.html_safe
    end
  end
end
