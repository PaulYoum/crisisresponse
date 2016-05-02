require "csv"
require "net/http"
require "rms_adapter"

class PeopleController < ApplicationController
  def index
    @search = PersonSearch.new(search_params)
    @people = @search.close_matches
  end

  def show
    @person = Person.find(params[:id])
    ensure_person_is_approved(@person)
  end

  private

  def events_for(person)
    rms = RMSAdapter.new
    rms.events_for(person)
  end

  def search_params
    if params[:person_search].present?
      params.require(:person_search).permit(:name, :date_of_birth)
    else
      {}
    end
  end

  def ensure_person_is_approved(person)
    unless person.approved?
      raise ActiveRecord::RecordNotFound
    end
  end
end
