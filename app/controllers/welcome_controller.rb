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

  def newsletter
    if params[:mailaddress] =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      @user = User.create(name: params[:name], email: params[:mailaddress])

      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_later
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
