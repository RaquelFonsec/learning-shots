class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
      if params[:filter].present?
        @trails = Trail.where(category: params[:filter].capitalize)
      else
      @trails = Trail.all
      end
      end

      def my_trails
        @trails = current_user.trails
      end
    end
