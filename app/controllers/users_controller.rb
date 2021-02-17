class UsersController < ApplicationController
  before_action :set_paper_trail_whodunnit

  def index
    render jsonapi: User.all
  end

  def archive
    user = User.find_by(id: params[:id])
    user.delete
    render jsonapi: user, status: :ok
  end

  def unarchive
    user = User.only_deleted.find_by(id: params[:id])
    user.restore(recursive: true)
    render jsonapi: user, status: :ok
  end
end
