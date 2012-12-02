# encoding: utf-8
class UserSessionsController < ApplicationController

  # GET /user_sessions/new
  # GET /user_sessions/new.json
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_session }
    end
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to :home, notice: 'Vítej!' }
        format.json { render json: @user_session, status: :created, location: :users }
      else
        format.html { redirect_to :home }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to :home, :notice => 'Měj se.' }
      format.json { head :no_content }
    end
  end
end
