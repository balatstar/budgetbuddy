class PaymentsController < ApplicationController
  before_action :set_group, only: %i[ index new create destroy ]
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  def index
    if @group
      @payments = @group.payments
    else
      @payments = current_user.payments
    end
  end

  # GET /payments/1 or /payments/1.json
  def show
    @payment = Payment.find(params[:id])
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.author_id = current_user.id

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @group = @payment.groups.first if @group.nil? && @payment.present?
    
    @payment.destroy!

    respond_to do |format|
      format.html { redirect_to group_payments_path(@group), notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_group
      @group = params[:group_id] ? Group.find(params[:group_id]) : nil
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:name, :amount, group_ids: [])
    end
end
