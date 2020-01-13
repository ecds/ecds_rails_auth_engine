class ApplicationController < ActionController::Base
  include EcdsRailsAuthEngine::CurrentUser
end
