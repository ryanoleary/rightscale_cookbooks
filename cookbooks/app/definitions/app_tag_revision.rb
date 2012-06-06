define :app_tag_revision do
  
  # Set the revision tag of the server
  revision_tag = "appserver:app_revision=#{node[:repo][:default][:revision]}"
  right_link_tag revision_tag  


end

