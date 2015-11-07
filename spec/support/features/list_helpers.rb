module Features
  def have_list(name)
    have_role_with_text("list", name)
  end
end
