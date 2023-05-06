class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    #@items = Item.where(publicznosc: 'true')
    @pagy, @items = pagy(Item.all, items: 20)
  end


  # GET /items/1 or /items/1.json
  def show
  end


  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    unless current_user == @item.user
      redirect_to items_path, alert: 'Nie masz uprawnień do edycji tego elementu.'
    end
  end


  # POST /items or /items.json
  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end


  def my_items
    @items = current_user.items
  end

  def update
    @item = Item.find(params[:id])

    if @item.user == current_user # Sprawdź, czy użytkownik jest właścicielem elementu
      if @item.update(item_params)
        redirect_to @item, notice: 'Item was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to root_path, alert: "You are not authorized to edit this item."
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :title, :content, :publicznosc, :cover_image)
    end
end
