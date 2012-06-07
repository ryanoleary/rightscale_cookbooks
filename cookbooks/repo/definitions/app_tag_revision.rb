#
# Cookbook Name:: repo 
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Sets a tag on this server to indicate which revision of the app is currently installed
#
# @param revision_name(String):: The name of the revision that will be set on the tag
define :app_tag_revision, :revision_name => 'unknown' do
  revision_name = params[:revision]
  
  # Set the revision tag of the server
  revision_tag = "appserver:app_revision=#{revision_name}"
  right_link_tag revision_tag  

end

