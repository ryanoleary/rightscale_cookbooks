#
# Cookbook Name:: db
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

# Check variables and log/skip if not set
skip, reason = true, "DB/Schema name not provided"           if node[:db][:dump][:database_name] == ""

if skip
  log "  Skipping import: #{reason}"
else

  db_name      = node[:db][:dump][:database_name]

  # Create the blank database
  db node[:db][:data_dir] do
    db_name db_name
    action :create_blank_database
  end

end

rightscale_marker :end
