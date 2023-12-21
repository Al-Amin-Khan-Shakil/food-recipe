class FoodsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @food = Food.new
    @user = current_user
    respond_to do |format|
      format.html { render :new, locals: { food: @food } }
    end
  end

  def create
    @user = current_user
    @food = @user.foods.build(food_params)

    respond_to do |format|
      format.html do
        if @food.save
          flash[:success] = 'Food saved successfully'
          redirect_to foods_url
        else
          flash.now[:error] = 'Error: Food could not be saved'
          render :new, locals: { food: @food }
        end
      end
    end
  end

  def index
    @foods = current_user.foods
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy
    flash[:success] = 'Food deleted successfully'
    redirect_to foods_url
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
