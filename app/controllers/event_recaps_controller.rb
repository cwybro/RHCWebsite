class EventRecapsController < ApplicationController
  before_action :set_event_recap, only: [:show, :edit, :update, :destroy]

  # GET /event_recaps
  # GET /event_recaps.json
  # TODO: Don't actually need this
  def index
    @event_recaps = EventRecap.all
  end

  # GET /event_recaps/1
  # GET /event_recaps/1.json
  def show
  end

  # GET /event_recaps/new
  def new
    @event = Event.find(params[:event_id])
    @event_recap = EventRecap.new
  end

  # GET /event_recaps/1/edit
  def edit
  end

  # POST /event_recaps
  # POST /event_recaps.json
  def create
    @event = Event.find(params[:event_id])
    @event_recap = EventRecap.new(event_recap_params)

    respond_to do |format|
      if @event_recap.save
        format.html { redirect_to @event_recap, notice: 'Event recap was successfully created.' }
        format.json { render :show, status: :created, location: @event_recap }
      else
        format.html { render :new }
        format.json { render json: @event_recap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_recaps/1
  # PATCH/PUT /event_recaps/1.json
  def update
    respond_to do |format|
      if @event_recap.update(event_recap_params)
        format.html { redirect_to @event_recap, notice: 'Event recap was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_recap }
      else
        format.html { render :edit }
        format.json { render json: @event_recap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_recaps/1
  # DELETE /event_recaps/1.json
  def destroy
    @event_recap.destroy
    respond_to do |format|
      format.html { redirect_to event_recaps_url, notice: 'Event recap was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_recap
      @event_recap = EventRecap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_recap_params
      params.require(:event_recap).permit(:attendance, :description)
    end
end
