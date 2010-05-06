require 'rubygems'
require 'sinatra'

set :run, false
set :environment, :development

require 'index'
run Sinatra::Application
