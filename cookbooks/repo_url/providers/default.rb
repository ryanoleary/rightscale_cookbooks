#
# Cookbook Name:: repo_ros
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

action :setup_attributes do

  # Checking inputs required for getting source from URL
  raise "  Repo repository is unset." unless new_resource.repository

end

action :pull do

  # Checking attributes
  action_setup_attributes

  log "  Trying to get URL repo from: #{new_resource.repository} using wget"

  # Backup project directory if it is not empty
  ruby_block "Backup of existing project directory" do
     block do
       ::File.rename("#{new_resource.destination}", "#{new_resource.destination}_" + ::Time.now.gmtime.strftime("%Y%m%d%H%M"))
     end
     not_if { ::Dir["#{new_resource.destination}/*"].empty? }
  end

  # Ensure that destination directory exists after all backups.
  directory "#{new_resource.destination}"

  # "true" we just put downloaded file into "destination" folder
  # "false" we put downloaded file into /tmp and unpack it into "destination" folder
  if (new_resource.unpack_source == true)
    tmp_repo_path = "/tmp/downloaded_ros_archive.tar.gz"
  else
    tmp_repo_path = "#{new_resource.destination}/downloaded_ros_archive.tar.gz"
  end
  log "  Downloaded file will be available in #{tmp_repo_path}"

  # Download the remote file
  remote_file tmp_repo_path do
    source new_resource.repository
    mode "0644"
  end

  bash "Unpack #{tmp_repo_path} to #{new_resource.destination}" do
    cwd "/tmp"
    code <<-EOH
      tar xzf #{tmp_repo_path} -C #{new_resource.destination}
    EOH
    only_if { (new_resource.unpack_source == true) }
  end

  log "  URL repo pull action - finished successfully!"
end


action :capistrano_pull do

  raise "  capistrano_pull not supported by URL Repo provider. Please change repo/default/perform_action to 'pull'"


end
