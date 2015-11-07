module Features
  def have_role(role)
    have_css("[data-role=#{role}]")
  end

  def have_role_with_text(role, text)
    have_css("[data-role=#{role}]", text: text)
  end
end
