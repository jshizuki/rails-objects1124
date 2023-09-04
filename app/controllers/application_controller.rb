class ApplicationController < ActionController::Base
  before_action :authenticate_objects_user!
end
