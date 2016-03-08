#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'
require 'bundler'
Bundler.require

require 'open-uri'

class ReadableApp < Sinatra::Base

  enable :sessions

  configure {
    set :server, :puma
  }

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

  get '/api/readable' do
    url = params[:url] || 'https://Readom.github.io/readable/'
    source = open(url).read
    options = {:tags => %w[div p img pre code a], :attributes => %w[src href], :remove_empty_nodes => false, :ignore_image_format => []}
    result = Readability::Document.new(source, options).content

    result
  end
end
