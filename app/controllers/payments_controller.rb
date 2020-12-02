class PaymentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  before_action :authorize_read_payments_permissons, only: [:index]
  before_action :authorize_read_permission, only: [:show]
  before_action :authorize_manage_permission, except: [:index, :show]

  add_breadcrumb I18n.t(:label_payments), :payments_path
  # GET /payments
  # GET /payments.json
  def index
    page = params[:page] || 1
    @payments = Payment.payments_of_user(current_user).page page
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    add_breadcrumb @payment.description, payment_path(@payment)
  end

  # GET /payments/new
  def new
    add_breadcrumb I18n.t(:label_new_payment), new_payment_path
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
    add_breadcrumb I18n.t(:label_editing_payment), edit_payment_path(@payment)
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.user = current_user

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    begin
      @payment = Payment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
        format.any  { head :not_found }
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:description, :amount, :tag_list)
  end

  def authorize_read_payments_permissons
    authorize! :read_own_payments, Payment.new
  end

  def authorize_read_permission
    authorize! :read, @payment
  end

  def authorize_manage_permission
    payment = @payment || Payment.new(user_id: current_user.id)
    authorize! :manage, payment
  end
end
