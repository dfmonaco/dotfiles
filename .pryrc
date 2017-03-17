require 'rubygems'
# require 'interactive_editor'

alias q exit

railsrc_path = File.expand_path('~/.railsrc')
if ( ENV['RAILS_ENV'] || defined? Rails ) && File.exist?( railsrc_path )
  begin
    load railsrc_path
  rescue Exception => e
    warn "Could not load: #{ railsrc_path } because of #{e}"
  end
end
