class Api::V1::RegistrationsController<Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  #signUp
  def create
    user=User.new(user_params)
    if user.save
      json_response "signed up successfully", true,{user: user}, :ok
      # render json:{
      #   message:"signed up successfully",
      #   is_success: true ,
      #   data:{
      #     user: user
      #   }
      # }, status: :ok
    else
      json_response "something went wrong", false ,{}, :unprocessable_entity

      # render json:{
      #   message: "something went wrong",
      #   is_success: false,
      #   data:{}
      # },status: :unprocessable_entity
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  def ensure_params_exist
    return  if params[:user].present?
    json_response "missing params", false ,{}, :bad_request

    # render json: {
    #   message: "missing params",
    #   is_success:false ,
    #   data:{}
    # },status: :bad_request


  end
end