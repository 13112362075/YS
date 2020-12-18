class ApplicationController < ActionController::Base
    include SessionsHelper 
    include DataCheckHelper
end
