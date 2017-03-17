require 'rubygems'
require 'irb/completion'

alias q exit

IRB.conf[:AUTO_INDENT]=true

begin
  require "ap"
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
rescue LoadError => e
  puts "ap gem not found.  Try typing 'gem install awesome_print' to get super-fancy output."
end

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError => e
  warn "Couldn't load Wirble: #{e}"
end

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

railsrc_path = File.expand_path('~/.railsrc')
if ( ENV['RAILS_ENV'] || defined? Rails ) && File.exist?( railsrc_path )
  begin
    load railsrc_path
  rescue Exception => e
    warn "Could not load: #{ railsrc_path } because of #{e}"
  end
end

