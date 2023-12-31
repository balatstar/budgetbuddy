class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  # GET /groups or /groups.json
  def index
    @groups = current_user.groups
    @page_title = 'Categories'
    @total_payments_amounts = @groups.map(&:total_payments_amount)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @page_title = 'Category'
    @total_payments_amount = @group.total_payments_amount
  end

  # GET /groups/new
  def new
    @page_title = 'New Category'
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @page_title = 'Update Category'
  end

  # POST /groups or /groups.json
  def create
    @page_title = 'Categories'
    @group = Group.new(group_params)
    @group.user = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    @page_title = 'Categories'
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_payments_path(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @page_title = 'Categories'
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
