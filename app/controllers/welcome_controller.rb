class WelcomeController < ApplicationController

  def index
  end

  def shop
  end

  def manage_shop

    render :manage_shop
  end

  def add_shop_entry
    begin
      last_entry = ShopEntry.order("id DESC").first
      if last_entry.nil?
        id = 1
      else
        id = last_entry[:id] + 1
      end

      #uploaded_io = params[:picture]
      #File.open(Rails.root.join('app', 'assets','images', uploaded_io.original_filename), 'wb') do |file|
      #  file.write(uploaded_io.read)
      #end
      #ShopEntry.create(id: id, price: params[:price], description: params[:description], photo: uploaded_io.original_filename)

      ShopEntry.create(id: id, price: params[:price], description: params[:description], photo: params[:picture])

      flash[:notice] = "De nieuwe entry werd succesvol toegevoegd (ID #{id})"
    rescue
      flash[:error] = "De nieuwe entry kon niet toegevoegd worden (zijn alle velden ingevuld?)"
    end


    render :manage_shop
  end

  def delete_shop_entry
    begin
      #photo = ShopEntry.where(id: params[:id]).first[:photo]
      #File.delete(photo) if File.exist?(photo)
      ShopEntry.destroy_all(id: params[:id])

      flash[:notice] = "Entry #{params[:id]} werd succesvol verwijderd"
    rescue
      flash[:error] = "Entry #{params[:id]} kon niet verwijderd worden"
    end
    render :manage_shop
  end

    def add_workshop_entry
    begin
      last_entry = ShopEntry.order("id DESC").first
      if last_entry.nil?
        id = 1
      else
        id = last_entry[:id] + 1
      end

      #uploaded_io = params[:picture]
      #File.open(Rails.root.join('app', 'assets','images', uploaded_io.original_filename), 'wb') do |file|
      #  file.write(uploaded_io.read)
      #end
      #ShopEntry.create(id: id, price: params[:price], description: params[:description], photo: uploaded_io.original_filename)

      WorkshopEntry.create(day: params[:day], month: params[:month], description: params[:description], photo: params[:picture])

      flash[:notice] = "De nieuwe entry werd succesvol toegevoegd"
    rescue
      flash[:error] = "De nieuwe entry kon niet toegevoegd worden (zijn alle velden ingevuld?)"
    end


    render :manage_shop
  end

  def delete_workshop_entry
    begin
      result = WorkshopEntry.destroy_all("day = '#{params[:day]}' AND month = '#{params[:month]}'")
      puts '-------------------------------'
      puts result
      puts '-------------------------------'

      if !result.nil?
        flash[:notice] = "Entry met dag '#{params[:day]}' en maand '#{params[:month]}' werd succesvol verwijderd"
      else
        flash[:error] = "Entry met dag '#{params[:day]}' en maand '#{params[:month]}' kon niet verwijderd worden"
      end
    rescue
      flash[:error] = "Entry met dag '#{params[:day]}' en maand '#{params[:month]}' kon niet verwijderd worden"
    end
    render :manage_shop
  end

  def order_entry1
    UserMailer.new_order_email1(params[:id], params[:name], params[:email]).deliver_later
    UserMailer.order_email1(params[:id], params[:name], params[:email]).deliver_later

    flash[:notice] = "Uw aanvraag werd verwerkt!"
    render :shop
  end

  def order_entry2
    UserMailer.new_order_email2(params[:id], params[:name], params[:email], params[:street], params[:streetnumber], params[:postalcode], params[:city]).deliver_later
    UserMailer.order_email2(params[:id], params[:name], params[:email], params[:street], params[:streetnumber], params[:postalcode], params[:city]).deliver_later

    flash[:notice] = "Uw aanvraag werd verwerkt!"
    render :shop
  end

  def newsletter
    if params[:mailaddress] =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      @user = User.create(name: params[:name], email: params[:mailaddress])

      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_later
        UserMailer.new_subscriber_email(@user).deliver_later
      end
    else
      puts "unvalid mailaddress: #{params[:mailaddress]}"
    end

    render :index
  end

  private
  def is_valid_email?(email)
  (email =~ /^(([A-Za-z0-9]*\.+*_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\+)|([A-Za-z0-9]+\+))*[A-Z‌​a-z0-9]+@{1}((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,4}$/i)
  end
end
