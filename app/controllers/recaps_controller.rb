class RecapsController < ApplicationController
  before_action :set_event 
  before_action :set_recap, only: [:edit, :update]

  # TODO: Don't actually need this
  # def index
  #   @event_recaps = EventRecap.all
  # end

  # TODO: Don't actually need this
  # def show
  # end

  def new
    @recap = Recap.new
  end

  def edit
  end

  def create
    begin
      @recap = Recap.new(recap_params)
      @event.recap = @recap
      flash[:notice] = 'Event recap was successfully created!'
      redirect_to(event_path(@event))
    rescue
      flash[:warning] = 'Error encountered when creating event recap'
      redirect_to(new_event_recap_path(@event))
    end
  end

  def update
    if @recap.update(recap_params)
      flash[:notice] = 'Event recap was successfully updated!'
      @event.recap = @recap
      redirect_to(event_path(@event))
    else
      flash[:warning] = 'Error encountered when creating event recap'
      redirect_to(edit_event_recap_path(@event))
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
    def set_event
      begin
        @event = Event.find(params[:event_id])
      rescue ActiveRecord::RecordNotFound
        flash[:warning] = "Invalid id, event not found"
        redirect_to events_path and return
      end
    end

    def set_recap
      @recap = @event.recap
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recap_params
      params.require(:recap).permit(:attendance, :description)
    end
end
