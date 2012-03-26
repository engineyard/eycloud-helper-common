# Usage examples:
#
# Also can append if file exists, else create it.
# update_file "add-#{name}-to-sysctl" do
#   action :append
#   path '/etc/sysctl.conf'
#   body "#{name} = #{value}"
# end
#
# Can also overwrite existing file if it exists.
# update_file "/tmp/cron_update_header" do
#   action :rewrite
# 
#   body <<-CRON
# PATH=/bin:/usr/bin:/usr/local/ey_resin/bin
# RAILS_ENV="#{node['environment']['framework_env']}"
# RACK_ENV="#{node['environment']['framework_env']}"
# CRON
# end
#
# Can replace a selection of existing file:
# update_file "/data/myapp/current/Gemfile" do
#   action :replace
#   where /(\s+)gem ['"]somegem['"].*$/
#   body "$1gem 'somegem', :git => 'git://github.com/engineyard/somegem.git'"
# end
#
# Default action is to :append. If `where` is specified, the defaults to :replace
# update_file "local portage package.use" do
#   path "/etc/portage/package.use/local"
#   body full_name
#   not_if "grep '#{full_name}' /etc/portage/package.use/local"
# end
#
define :update_file, :action => :append do

  filepath = params[:path] || params[:name]

  file filepath do
    action :create_if_missing
    backup params[:backup] if params[:backup]
    group params[:group] if params[:group]
    mode params[:mode] if params[:mode]
    owner params[:owner] if params[:owner]
    path filepath
    not_if params[:not_if] if params[:not_if]
    only_if params[:only_if] if params[:only_if]
  end

  params[:action] = :replace if params[:where]
  
  case params[:action].to_sym
  when :append, :rewrite

    mode = params[:action].to_sym == :append ? '>>' : '>'

    execute "echo '#{params[:body]}' #{mode} #{filepath}" do
      not_if params[:not_if] if params[:not_if]
      only_if params[:only_if] if params[:only_if]
    end

  when :replace

    ruby_block do
      content = File.binread(params[:path])
      content.gsub!(params[:where], params[:body])
      File.open(path, 'wb') { |file| file.write(content) }
    end

  when :truncate

    execute "> #{filepath}" do
      not_if params[:not_if] if params[:not_if]
      only_if params[:only_if] if params[:only_if]
    end

  end
end
