require 'rspec'
require 'page-object'
require 'data_magic'
require 'require_all'
require 'faker'
require 'active_support/time'
require 'pdf-reader'
require 'open-uri'
require 'net/http'
require 'json'
require 'watir-webdriver-performance'
require File.dirname(__FILE__) + '/test_config'
require File.dirname(__FILE__) + '/url_factory.rb'
require File.dirname(__FILE__) + '/page_factory_override.rb'
require_all File.dirname(__FILE__) + '/pages'
require_all File.dirname(__FILE__) + '/api'

World(PageObject::PageFactory)
World(PageFactoryOverride)