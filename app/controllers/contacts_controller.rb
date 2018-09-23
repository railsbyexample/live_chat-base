class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
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
        format.html { redirect_to users_url, notice: 'Contact was successfully created, they must accept your request before you can talk' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    unless @contact.receiver == current_user
      redirect_to contacts_url, alert: "You can't confirm your own invitation"
      return
    end

    @contact.confirm

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully updated.' }
      format.json { render :show, status: :ok, location: @contact }
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    unless @contact.sender == current_user || @contact.receiver == current_user
      redirect_to contacts_url, alert: "You can't access this record"
      return
    end

    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:sender_id, :receiver_id, :confirmed_at)
    end
end
