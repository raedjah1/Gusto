class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chef_profile
  
    def index
      reviews = @chef_profile.reviews
      render json: reviews
    end
  
    def create
      review = @chef_profile.reviews.build(review_params.merge(user: current_user))
      if review.save
        render json: review, status: :created
      else
        render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_chef_profile
      @chef_profile = ChefProfile.find(params[:chef_profile_id])
    end
  
    def review_params
      params.require(:review).permit(:rating, :comments)
    end
  end
  