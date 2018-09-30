class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:update, :destroy]

  # GET /contacts
  def index
    contacts = current_user.contacts.confirmed

    render '/shared/react_view',
           locals: {
             component_name: 'contacts/Index',
             prop_name: 'contacts',
             prop_partial: 'contacts/contacts',
             prop_partial_locals: { contacts: contacts, included: { contact: %i[last_message] } }
           }
  end

  # GET /contacts/1
  def show
    contact = Contact.find(params[:id])
    render '/shared/react_view',
           locals: {
             component_name: 'contacts/Show',
             prop_name: 'contact',
             prop_partial: 'contacts/contact',
             prop_partial_locals: { contact: contact, included: %i[messages] }
           }
  end

  # GET /contacts/new
  def new
    unconfirmed_contacts = current_user.contacts.unconfirmed
    render '/shared/react_view',
           locals: {
             component_name: 'contacts/New',
             prop_name: 'unconfirmed_contacts',
             prop_partial: 'contacts/contacts',
             prop_partial_locals: { contacts: unconfirmed_contacts }
           }
  end

  # POST /contacts
  def create
    @contact = Contact.new
    receiver_email = params[:contact][:email]


    if receiver_email == current_user.email
      redirect_to new_contact_url, alert: "You can't add yourself, for now."
      return
    end

    receiver = User.find_by(email: receiver_email)

    unless receiver.present?
      redirect_to new_contact_url, alert: 'User is not registered on MessRb.'
      return
    end

    existing_contact = receiver.contact_with(current_user.id)

    if existing_contact.present?
      redirect_to new_contact_url, alert: 'You already have a contact request with this user.'
      return
    end

    @contact = Contact.create(sender: current_user, receiver: receiver)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to new_contact_url, notice: 'Contact was successfully created, they must accept your request before you can talk' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  def update
    unless @contact.receiver == current_user
      redirect_to contacts_url, alert: "You can't confirm your own invitation"
      return
    end

    @contact.confirm

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully accepted.' }
      format.json { render :show, status: :ok, location: @contact }
    end
  end

  # DELETE /contacts/1
  def destroy
    unless @contact.sender == current_user || @contact.receiver == current_user
      redirect_to contacts_url, alert: "You can't access this record"
      return
    end

    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:sender_id, :receiver_id, :confirmed_at)
  end
end
