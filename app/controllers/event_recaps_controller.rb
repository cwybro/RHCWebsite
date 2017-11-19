class EventRecapsController < ApplicationController
  before_action :set_event_recap, only: [:show, :edit, :update, :destroy]

  # TODO: Don't actually need this
  # def index
  #   @event_recaps = EventRecap.all
  # end

  # TODO: Don't actually need this
  # def show
  # end

  def new
    @event = Event.find(params[:event_id])
    @event_recap = EventRecap.new
  end

  def edit
    @event = Event.find(params[:event_id])
    @event_recap = @event.event_recap
  end

  def create
    @event = Event.find(params[:event_id])
    @event_recap = EventRecap.new(event_recap_params)
    @event.event_recap = @event_recap
    if @event_recap.save
      flash[:notice] = 'Event recap was successfully created!'
      redirect_to(event_path(@event))
    else
      flash[:alert] = 'Error encountered when creating event recap'
      redirect_to(new_event_event_recap_path(@event))
    end
  end

  def update
    @event = Event.find(params[:event_id])
    if @event_recap.update(event_recap_params)
      flash[:notice] = 'Event recap was successfully updated!'
      @event.event_recap = @event_recap
      redirect_to(event_path(@event))
    else
      flash[:alert] = 'Error encountered when creating event recap'
      redirect_to(new_event_event_recap_path(@event))
    end
  end

  # TODO: Don't actually need this
  # def destroy
  #   @event_recap.destroy
  #   respond_to do |format|
  #     format.html { redirect_to event_recaps_url, notice: 'Event recap was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_recap
      @event_recap = Event.find(params[:event_id]).event_recap
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_recap_params
      params.require(:event_recap).permit(:attendance, :description)
    end
end
