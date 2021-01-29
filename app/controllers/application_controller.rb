class ApplicationController < ActionController::Base
    include SessionsHelper 
    include DataCheckHelper
    include AssetcardsHelper
end
